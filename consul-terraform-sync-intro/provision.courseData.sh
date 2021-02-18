cat << 'EOFSRSLY' > /tmp/provision.sh
#! /bin/bash

# ++-----------------+
# || Functions       |
# ++-----------------+

## Prints a line on stdout prepended with date and time
log() {
  echo -e "\033[1m["$(date +"%Y-%d-%d %H:%M:%S")"] - ${@}\033[0m"
}

finish() {
  touch /provision_complete
  log "Complete!  Move on to the next step."
}

log "Install prerequisites"
# apt-get install -y apt-utils > /dev/null
apt-get install -y unzip curl jq > /dev/null

## Prints a header on stdout
header() {

  echo -e " \033[1m\033[32m"

  echo ""
  echo "++----------- " 
  echo "||   ${@} "
  echo "++------      " 

  echo -e "\033[0m"
}

## Prints environment variables to be used to configure local machine
## for communicating with the server directly
print_vars() {

  echo "export CONSUL_HTTP_ADDR=https://${SERVER_IP}:443"
  echo "export CONSUL_HTTP_TOKEN=${CONSUL_HTTP_TOKEN}"
  echo "export CONSUL_HTTP_SSL=true"
  ## This is a boolean value (default true) to specify 
  # SSL certificate verification; setting this value to 
  # false is not recommended for production use. 
  # Example for development purposes:
  echo "export CONSUL_HTTP_SSL_VERIFY=false"

}

## Prints environment variables to be used to configure local machine
## for communicating with the local Consul agent
print_vars_local () {
  echo "export CONSUL_HTTP_ADDR=http://localhost:8500"
  echo "export CONSUL_HTTP_TOKEN=${CONSUL_HTTP_TOKEN}"
}

## Cleans environment by removing containers and volumes
clean_env() {

  if [[ $(docker ps -aq --filter label=tag=learn) ]]; then
    docker rm -f $(docker ps -aq --filter label=tag=learn)
  fi

  if [[ $(docker volume ls -q --filter label=tag=learn) ]]; then
    docker volume rm $(docker volume ls -q --filter label=tag=learn)
  fi

  if [[ $(docker network ls -q --filter label=tag=learn) ]]; then
    docker network rm $( docker network ls -q --filter label=tag=learn)
  fi

  ## Remove certificates 
  rm -rf ${ASSETS}secrets
  
  ## Unset variables
  unset CONSUL_HTTP_ADDR
  unset CONSUL_HTTP_TOKEN
  unset CONSUL_HTTP_SSL
  unset CONSUL_CACERT
  unset CONSUL_CLIENT_CERT
  unset CONSUL_CLIENT_KEY

}

## Prints for each container the ports used
## and the process listening on those ports.
show_ports() {
  for i in `docker container ls --filter label=tag=learn --format "{{.Names}}"`; do 
    
    CONT_IP=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $i`
    
    echo "======================="; 
    echo -e "$i - ${CONT_IP}"; 
    echo "======================="; 
    
    # docker exec $i netstat -natp | grep LISTEN; 
    docker exec $i netstat -natp | grep LISTEN | awk '{print $7"\t: "$4}' | sed 's/[0-9]*\///g' | sort ; 
    
    echo ""
  done

}

## Relies on the existence of the `operator` container
op_exec() {

  CONTAINER_NAME=$1
  CONSUL_SERVER_AND_PORT=$2
  CONSUL_TOKEN=$3
  CONSUL_COMMAND=$4

  docker exec \
    -w /assets \
    --env CONSUL_HTTP_ADDR=https://${CONSUL_SERVER_AND_PORT} \
    --env CONSUL_HTTP_TOKEN=${CONSUL_TOKEN} \
    --env CONSUL_HTTP_SSL=true \
    --env CONSUL_HTTP_SSL_VERIFY=false \
    ${CONTAINER_NAME} bash -c "${CONSUL_COMMAND}"

}

# ++-----------------+
# || Variables       |
# ++-----------------+

## Number of servers to spin up 3 or 5 is the recommended set to pass in a
## production environment
SERVER_NUMBER=1
## For the sandbox we used a Docker container to simulate a VM-like scenario
## The Docker image was built starting from envoyproxy/envoy-alpine to easily
## provide the Envoy proxy and Consul binary was added alongside with a go
## application (/usr/local/bin/fake-service) that will be used to simulate a
## three-tier application scenario.
IMAGE_NAME=danielehc/consul-learn-image
CONSUL_VERSION=1.9.3
ENVOY_VERSION=1.16.0
IMAGE_TAG=v${CONSUL_VERSION}-v${ENVOY_VERSION}

## Define datacenter and domain for the sandbox Consul DC
DATACENTER="dc1"
DOMAIN="consul"

ASSETS="./assets/"

# ++-----------------+
# || Begin           |
# ++-----------------+

## Check Parameters
if   [ "$1" == "clean" ]; then

  clean_env
  exit 0

elif [ "$1" == "ports" ]; then

  show_ports
  exit 0

fi

########## ------------------------------------------------
header     "PREREQUISITES CHECK"
###### -----------------------------------------------

log "Cleaning Environment"
clean_env

log "Pulling Docker Images"
docker pull ${IMAGE_NAME}:${IMAGE_TAG} > /dev/null

########## ------------------------------------------------
header     "GENERATE NETWORKS"
###### -----------------------------------------------

docker network create primary   --subnet=172.19.0.0/24 --label tag=learn
# docker network create secondary --subnet=172.19.2.0/24 --label tag=learn
# docker network create public    --subnet=172.19.0.0/24 --label tag=learn

########## ------------------------------------------------
header     "GENERATE DYNAMIC CONFIGURATION"
###### -----------------------------------------------
log "Starting Operator container"
docker run \
  -d \
  -v ${PWD}/assets:/assets \
  --net primary \
  --user $(id -u):$(id -g) \
  --name=operator \
  --hostname=operator \
  --label tag=learn \
  ${IMAGE_NAME}:${IMAGE_TAG} "" > /dev/null 2>&1

log "Generating Consul certificates and key"

docker exec \
  -w /assets \
  operator bash -c \
    'mkdir -p ./secrets; \
    cd ./secrets; \
    echo Generate gossip encyption key; \
    echo encrypt = \"$(consul keygen)\" > agent-gossip-encryption.hcl;'

docker exec \
  -w /assets/secrets \
  operator bash -c \
    "echo Generate CA certificate; \
    consul tls ca create -domain=\"${DOMAIN}\" > /dev/null 2>&1;" 

docker exec \
  -w /assets/secrets \
  operator bash -c \
    "echo Generate certificate for servers; \
    for ((i = 0 ; i <= ${SERVER_NUMBER} ; i++)); do \
      consul tls cert create -server -domain=${DOMAIN} -dc=${DATACENTER} > /dev/null 2>&1; \
    done" 

for ((i = 1 ; i <= ${SERVER_NUMBER} ; i++)); do
  tee ${ASSETS}secrets/agent-${DATACENTER}-server-$i-tls.hcl > /dev/null << EOF
ca_file   = "/assets/secrets/consul-agent-ca.pem"
cert_file = "/assets/secrets/${DATACENTER}-server-${DOMAIN}-${i}.pem"
key_file  = "/assets/secrets/${DATACENTER}-server-${DOMAIN}-${i}-key.pem"
EOF
done

########## ------------------------------------------------
header     "CONSUL - Starting Primary Datacenter"
###### -----------------------------------------------

RETRY_JOIN=""
RETRY_JOIN_WAN=""

for i in $(seq 1 ${SERVER_NUMBER}); do 

  log "Starting Consul server $i"
  docker run \
    -d \
    -v ${PWD}/assets:/assets \
    --net primary \
    -p ${i}443:443 \
    --name=server-$i \
    --hostname=server-$i \
    --label tag=learn \
    --label dc=${DATACENTER} \
    --dns=127.0.0.1 \
    --dns-search=consul \
    ${IMAGE_NAME}:${IMAGE_TAG} \
    consul agent -server -ui \
      -datacenter=${DATACENTER} \
      -domain=${DOMAIN} \
      -node=server-$i \
      -client=127.0.0.1 \
      -bootstrap-expect=${SERVER_NUMBER} \
      -retry-join=${RETRY_JOIN} \
      -config-file=/assets/agent-server-secure.hcl \
      -config-file=/assets/secrets/agent-${DATACENTER}-server-$i-tls.hcl \
      -config-file=/assets/secrets/agent-gossip-encryption.hcl > /dev/null 2>&1
  
  ## Retrieve newly created server IP
  SERVER_IP=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' server-$i`

  ## Generate the retry-join string
  if [ -z "${RETRY_JOIN}" ]; then 
    RETRY_JOIN=${SERVER_IP};
    RETRY_JOIN_WAN=${SERVER_IP}; 
  else 
    RETRY_JOIN="${RETRY_JOIN} -retry-join=${SERVER_IP}";
    RETRY_JOIN_WAN="${RETRY_JOIN_WAN} -retry-join-wan=${SERVER_IP}";
  fi
done

########## ------------------------------------------------
header     "CONSUL - ACL configuration"
###### -----------------------------------------------

log "ACL Bootstrap"

op_exec operator ${SERVER_IP}:443 "" \
  "while ! consul acl bootstrap > ./secrets/acl-bootstrap.conf 2> /dev/null; do echo 'ACL system not ready. Retrying...'; sleep 5; done"

export CONSUL_HTTP_TOKEN=`cat ${ASSETS}/secrets/acl-bootstrap.conf | grep SecretID | awk '{print $2}'`

log "Create ACL Policies"
## DNS Policy for default tokens

op_exec operator ${SERVER_IP}:443 ${CONSUL_HTTP_TOKEN} \
  "consul acl policy create -name 'acl-policy-dns' -description 'Policy for DNS endpoints' -rules @acl-policy-dns.hcl  > /dev/null 2>&1"

op_exec operator ${SERVER_IP}:443 ${CONSUL_HTTP_TOKEN} \
  "consul acl policy create -name 'acl-policy-server-node' -description 'Policy for Server nodes' -rules @acl-policy-server-node.hcl  > /dev/null 2>&1"

log "Create ACL Tokens"

op_exec operator ${SERVER_IP}:443 ${CONSUL_HTTP_TOKEN} \
  "consul acl token create -description 'DNS - Default token' -policy-name acl-policy-dns > ./secrets/acl-dns-token.conf 2> /dev/null"

DNS_TOK=`cat ${ASSETS}secrets/acl-dns-token.conf | grep SecretID | awk '{print $2}'` 

## Create one agent token per server
for i in `seq 1 ${SERVER_NUMBER}`; do

  IP_ADDR=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' server-$i`

  op_exec operator ${SERVER_IP}:443 ${CONSUL_HTTP_TOKEN} \
    "consul acl token create -description \"server-$i agent token\" -policy-name acl-policy-server-node > ./secrets/acl-server-$i-token.conf 2> /dev/null"

  TOK=`cat ${ASSETS}secrets/acl-server-$i-token.conf | grep SecretID | awk '{print $2}'`

  op_exec operator ${IP_ADDR}:443 ${CONSUL_HTTP_TOKEN} \
    "consul acl set-agent-token agent ${TOK}"

  op_exec operator ${IP_ADDR}:443 ${CONSUL_HTTP_TOKEN} \
    "consul acl set-agent-token default ${DNS_TOK}"

done

########## ------------------------------------------------
header     "CONSUL - Service Mesh configuration"
###### -----------------------------------------------

log "Apply Configuration Entries"

## Envoy Proxy Defaults
op_exec operator ${SERVER_IP}:443 ${CONSUL_HTTP_TOKEN} \
  "consul config write config-proxy-defaults.hcl"

op_exec operator ${SERVER_IP}:443 ${CONSUL_HTTP_TOKEN} \
  "consul config write config-service-api.hcl"

op_exec operator ${SERVER_IP}:443 ${CONSUL_HTTP_TOKEN} \
  "consul config write config-service-web.hcl"

## Intention web > api
op_exec operator ${SERVER_IP}:443 ${CONSUL_HTTP_TOKEN} \
  "consul config write config-intentions-api.hcl"


########## ------------------------------------------------
header     "CONSUL - Starting Client Agents"
###### -----------------------------------------------

## TODO: Generate different token for client nodes
tee ${ASSETS}secrets/agent-client-tokens.hcl > /dev/null << EOF
acl {
  tokens {
    agent  = "${CONSUL_HTTP_TOKEN}"
    default  = "${DNS_TOK}"
  }
}
EOF

CONSUL_AGENT_TOKEN=${CONSUL_HTTP_TOKEN}

## API
docker run \
  -d \
  -v ${PWD}/assets:/assets \
  --net primary \
  --name=api \
  --hostname=api \
  --label tag=learn \
  --dns=127.0.0.1 \
  --dns-search=consul \
  ${IMAGE_NAME}:${IMAGE_TAG} \
  consul agent \
    -datacenter=${DATACENTER} \
    -domain=${DOMAIN} \
    -node=service-1 \
    -retry-join=${RETRY_JOIN} \
    -config-file=/assets/agent-client-secure.hcl \
    -config-file=/assets/secrets/agent-gossip-encryption.hcl \
    -config-file=/assets/secrets/agent-client-tokens.hcl > /dev/null 2>&1
     
    #  \
    #  -config-file=/etc/consul.d/svc-api.hcl 

## FRONTEND
docker run \
  -d \
  -v ${PWD}/assets:/assets \
  --net primary \
  -p 9002:9002 \
  --name=web \
  --hostname=web \
  --label tag=learn \
  --dns=127.0.0.1 \
  --dns-search=consul \
  ${IMAGE_NAME}:${IMAGE_TAG} \
  consul agent \
    -datacenter=${DATACENTER} \
    -domain=${DOMAIN} \
    -node=service-2 \
    -retry-join=${RETRY_JOIN} \
    -config-file=/assets/agent-client-secure.hcl \
    -config-file=/assets/secrets/agent-gossip-encryption.hcl \
    -config-file=/assets/secrets/agent-client-tokens.hcl > /dev/null 2>&1

## Start API
docker exec api sh -c "LISTEN_ADDR=127.0.0.1:9003 NAME=api fake-service > /tmp/service.log 2>&1 &"
## Start WEB
docker exec web sh -c "LISTEN_ADDR=0.0.0.0:9002 NAME=web UPSTREAM_URIS=\"http://localhost:5000\" fake-service > /tmp/service.log 2>&1 &"

## Register API service
docker exec \
  --env CONSUL_HTTP_ADDR='127.0.0.1:8500' \
  --env CONSUL_HTTP_TOKEN="${CONSUL_AGENT_TOKEN}" \
  api sh -c "consul services register /assets/svc-api.hcl"

## Register WEB service
docker exec \
  --env CONSUL_HTTP_ADDR='127.0.0.1:8500' \
  --env CONSUL_HTTP_TOKEN="${CONSUL_AGENT_TOKEN}" \
  web sh -c "consul services register /assets/svc-web.hcl"

log "Start Envoy sidecar proxies"
## Once the services are registered in Consul and the upsytram dependencies are
## specified 

## Start api sidecar
docker exec \
  --env CONSUL_HTTP_ADDR='127.0.0.1:8500' \
  --env CONSUL_GRPC_ADDR='127.0.0.1:8502' \
  --env CONSUL_HTTP_TOKEN="${CONSUL_AGENT_TOKEN}" \
  api sh -c "consul connect envoy -sidecar-for api-1 -admin-bind 0.0.0.0:19001 > /tmp/proxy.log 2>&1 &"

## Start web sidecar
docker exec \
  --env CONSUL_HTTP_ADDR='127.0.0.1:8500' \
  --env CONSUL_GRPC_ADDR='127.0.0.1:8502' \
  --env CONSUL_HTTP_TOKEN="${CONSUL_AGENT_TOKEN}" \
  web sh -c "consul connect envoy -sidecar-for web -admin-bind 0.0.0.0:19001 > /tmp/proxy.log 2>&1 &"

########## ------------------------------------------------
header     "CONSUL - Configure your local environment"
###### -----------------------------------------------

## Make config available
ln -s /root/assets /assets

## Copy consul binary locally
docker cp operator:/usr/local/bin/consul /usr/local/bin/consul

## CTS Client
consul agent -ui \
  -datacenter=${DATACENTER} \
  -domain=${DOMAIN} \
  -node=cts-node \
  -bind=172.19.0.1 \
  -retry-join=${RETRY_JOIN} \
  -config-file=/assets/agent-client-secure.hcl \
  -config-file=/assets/secrets/agent-gossip-encryption.hcl \
  -config-file=/assets/secrets/agent-client-tokens.hcl > /tmp/cts-consul.log 2>&1 &

# print_vars
print_vars_local | tee consul_env.conf

finish

EOFSRSLY

chmod +x /tmp/provision.sh
