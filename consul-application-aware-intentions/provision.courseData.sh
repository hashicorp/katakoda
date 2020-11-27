cat << 'EOFSRSLY' > /tmp/provision.sh
#! /bin/bash

log() {
  echo $(date) - ${@}
}

finish() {
  touch /provision_complete
  log "Complete!  Move on to the next step."
}

log "Install prerequisites"
# apt-get install -y apt-utils > /dev/null
apt-get install -y unzip curl jq > /dev/null

log Pulling Docker Image

IMAGE_TAG=v1.9.0-v1.16.0

docker pull danielehc/consul-learn-image:${IMAGE_TAG} > /dev/null

log Creating Docker volumes

docker volume create server_config > /dev/null
docker volume create client_config > /dev/null
docker container create --name volumes -v server_config:/server -v client_config:/client alpine > /dev/null

log Copying configuration files 

# Server files
docker cp ./config/agent-server.hcl volumes:/server/agent-server.hcl

# Client files
docker cp ./config/agent-client.hcl volumes:/client/agent-client.hcl
docker cp ./config/svc-api.hcl volumes:/client/svc-api.hcl
docker cp ./config/svc-web.hcl volumes:/client/svc-web.hcl
docker cp ./config/svc-counting.json volumes:/client/svc-counting.json
docker cp ./config/svc-dashboard.json volumes:/client/svc-dashboard.json

# Not copying them anymore and applying them from the operator node
# docker cp ./config/default-counting.hcl volumes:/server/default-counting.hcl
# docker cp ./config/default-dashboard.hcl volumes:/server/default-dashboard.hcl
# docker cp ./config/default-web.hcl volumes:/server/default-web.hcl
# docker cp ./config/default-api.hcl volumes:/server/default-api.hcl
# docker cp ./config/default-proxy.hcl volumes:/server/default-proxy.hcl
# docker cp ./config/config-intentions-api.hcl volumes:/server/config-intentions-api.hcl
# docker cp ./config/config-intentions-web.hcl volumes:/server/config-intentions-web.hcl
# docker cp ./config/config-intentions-default.hcl volumes:/server/config-intentions-default.hcl
# 
# docker cp ./config/igw-dashboard.hcl volumes:/client/igw-dashboard.hcl
# docker cp ./config/igw-web.hcl volumes:/client/igw-web.hcl
 
log Starting Consul Server

docker run \
  -d \
  -v server_config:/etc/consul.d \
  -p 8500:8500 \
  -p 53:8600/udp \
  --name=server \
  danielehc/consul-learn-image:${IMAGE_TAG} \
  consul agent -server -ui \
    -node=server-1 \
    -bootstrap-expect=1 \
    -client=0.0.0.0 \
    -config-file=/etc/consul.d/agent-server.hcl

# Retrieve server IP for client join
SERVER_IP=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' server`

log Configuring Operator Node

log - Setting Consul as DNS
echo -en "# Consul DNS Configuration\nnameserver 127.0.0.1\n\n" > /etc/resolvconf/resolv.conf.d/head
systemctl restart resolvconf.service

log  - Installing Applications Locally
docker cp server:/usr/local/bin/fake-service /usr/local/bin
docker cp server:/usr/local/bin/consul /usr/local/bin

log Starting Consul Clients

## BACKEND
docker run \
    -d \
    -v client_config:/etc/consul.d \
    -p 19001:19001 \
    --name=api \
    danielehc/consul-learn-image:${IMAGE_TAG} \
    consul agent \
     -node=service-1 \
     -join=${SERVER_IP} \
     -config-file=/etc/consul.d/agent-client.hcl \
     -config-file=/etc/consul.d/svc-api.hcl

# -config-file=/etc/consul.d/svc-counting.json \

## FRONTEND
docker run \
    -d \
    -v client_config:/etc/consul.d \
    -p 19002:19001 \
    -p 9002:9002 \
    --name=web \
    danielehc/consul-learn-image:${IMAGE_TAG} \
    consul agent \
     -node=service-2 \
     -join=${SERVER_IP} \
     -config-file=/etc/consul.d/agent-client.hcl \
     -config-file=/etc/consul.d/svc-web.hcl

#  -config-file=/etc/consul.d/svc-dashboard.json \

log Starting Ingress Gateway Node

## INGRESS GW
docker run \
    -d \
    -v client_config:/etc/consul.d \
    -p 8888:8888 \
    -p 8080:8080 \
    --name=ingress-gw \
    danielehc/consul-learn-image:${IMAGE_TAG} \
    consul agent \
     -node=ingress-gw \
     -join=${SERVER_IP} \
     -config-file=/etc/consul.d/agent-client.hcl

log Starting Applications and configuring service mesh

# Start applications
# set -x
# docker exec counter sh -c "PORT=9003 counting-service > /tmp/service.log 2>&1 &"
# docker exec dashboard sh -c "PORT=9002 COUNTING_SERVICE_URL=\"http://localhost:5000\" dashboard-service > /tmp/service.log 2>&1 &"

# Start sidecar proxies
# docker exec counter sh -c "consul connect envoy -sidecar-for counting-1 > /tmp/proxy.log 2>&1 &"
# docker exec dashboard sh -c "consul connect envoy -sidecar-for dashboard > /tmp/proxy.log 2>&1 &"
# set +x

# Start applications
set -x
docker exec api sh -c "LISTEN_ADDR=127.0.0.1:9003 NAME=api fake-service > /tmp/service.log 2>&1 &"
docker exec web sh -c "LISTEN_ADDR=0.0.0.0:9002 NAME=web UPSTREAM_URIS=\"http://localhost:5000\" fake-service > /tmp/service.log 2>&1 &"

# Start sidecar proxies
docker exec api sh -c "consul connect envoy -sidecar-for api-1 -admin-bind 0.0.0.0:19001 > /tmp/proxy.log 2>&1 &"
docker exec web sh -c "consul connect envoy -sidecar-for web -admin-bind 0.0.0.0:19001 > /tmp/proxy.log 2>&1 &"
set +x

log Apply Configuration Entries

## Envoy Proxy Defaults
consul config write ./config/config-proxy-defaults.hcl

## Counting - Dashboard Applications
consul config write ./config/config-service-counting.hcl
consul config write ./config/config-service-dashboard.hcl
consul config write ./config/igw-dashboard.hcl

## fake-service web/api
consul config write ./config/config-service-api.hcl
consul config write ./config/config-service-web.hcl
consul config write ./config/igw-web.hcl

## Default Deny intention
## [TODO] will be enabled by ACL default policy
consul config write ./config/config-intentions-default.hcl

# # Configure and start ingress gateway
# docker exec server consul config write /etc/consul.d/default-proxy.hcl
# # docker exec server consul config write /etc/consul.d/default-counting.hcl
# # docker exec server consul config write /etc/consul.d/default-dashboard.hcl
# # docker exec ingress-gw consul config write /etc/consul.d/igw-dashboard.hcl
# docker exec server consul config write /etc/consul.d/default-api.hcl
# docker exec server consul config write /etc/consul.d/default-web.hcl
# docker exec ingress-gw consul config write /etc/consul.d/igw-web.hcl
# docker exec server consul config write /etc/consul.d/config-intentions-default.hcl

log Start Ingress Gateway Instance
docker exec ingress-gw sh -c "consul connect envoy -gateway=ingress -register -service ingress-service -address '{{ GetInterfaceIP \"eth0\" }}:8888' > /tmp/proxy.log 2>&1 &"

finish

EOFSRSLY

chmod +x /tmp/provision.sh
