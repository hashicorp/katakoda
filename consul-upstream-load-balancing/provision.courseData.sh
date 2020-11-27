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

IMAGE_TAG=latest
IMAGE_TAG=v1.9.0-v1.16.0

docker pull danielehc/consul-learn-image:${IMAGE_TAG} > /dev/null


log Creating Docker volumes

docker volume create server_config > /dev/null
docker volume create client_config > /dev/null
docker container create --name volumes -v server_config:/server -v client_config:/client alpine > /dev/null

log Copying configuration files 

# Server files
docker cp ./server.hcl volumes:/server/server.hcl
docker cp ./default.hcl volumes:/server/default.hcl
docker cp ./hash-resolver.hcl volumes:/server/hash-resolver.hcl
docker cp ./least-req-resolver.hcl volumes:/server/least-req-resolver.hcl

docker cp ./igw-backend.hcl volumes:/server/igw-backend.hcl

# Client files
docker cp ./agent.hcl volumes:/client/agent.hcl
docker cp ./svc-client.hcl volumes:/client/svc-client.hcl
docker cp ./svc-clone.hcl volumes:/client/svc-clone.hcl
docker cp ./svc-main.hcl volumes:/client/svc-main.hcl

log Starting Consul Server

docker run \
  -d \
  -v server_config:/etc/consul.d \
  -p 8500:8500 \
  -p 8600:8600/udp \
  --name=server \
  danielehc/consul-learn-image:${IMAGE_TAG} \
  consul agent -server -ui \
    -node=server-1 \
    -bootstrap-expect=1 \
    -client=0.0.0.0 \
    -config-file=/etc/consul.d/server.hcl

SERVER_IP=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' server`

log Starting Consul Clients

docker run \
    -d \
    -v client_config:/etc/consul.d \
    --name=client \
    danielehc/consul-learn-image:${IMAGE_TAG} \
    consul agent \
     -node=client-1 \
     -join=${SERVER_IP} \
     -config-file=/etc/consul.d/agent.hcl \
     -config-file=/etc/consul.d/svc-client.hcl

docker run \
    -d \
    -v client_config:/etc/consul.d \
    --name=backend-main \
    danielehc/consul-learn-image:${IMAGE_TAG} \
    consul agent \
     -node=service-1 \
     -join=${SERVER_IP} \
     -config-file=/etc/consul.d/agent.hcl \
     -config-file=/etc/consul.d/svc-main.hcl

docker run \
    -d \
    -v client_config:/etc/consul.d \
    --name=backend-clone \
    danielehc/consul-learn-image:${IMAGE_TAG} \
    consul agent \
     -node=service-2 \
     -join=${SERVER_IP} \
     -config-file=/etc/consul.d/agent.hcl \
     -config-file=/etc/consul.d/svc-clone.hcl

log Starting Ingress Gateway

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
     -config-file=/etc/consul.d/agent.hcl

log Starting Applications and configuring service mesh

# Start applications
docker exec backend-main env LISTEN_ADDR=:9091 NAME=main fake-service > /tmp/service.log 2>&1 &
docker exec backend-clone env LISTEN_ADDR=:9092 NAME=clone fake-service > /tmp/service.log 2>&1 &

# Start sidecar proxies
docker exec backend-main consul connect envoy -proxy-id backend-main-sidecar-proxy > /tmp/proxy.log 2>&1 &
docker exec backend-clone consul connect envoy -admin-bind=localhost:19001 -proxy-id backend-clone-sidecar-proxy > /tmp/proxy.log 2>&1 &
docker exec client consul connect envoy -admin-bind=localhost:19002 -proxy-id client-sidecar-proxy > /tmp/proxy.log 2>&1 &

# Configure and start ingress gateway
docker exec server consul config write /etc/consul.d/default.hcl
docker exec server consul config write /etc/consul.d/igw-backend.hcl
docker exec ingress-gw consul connect envoy -gateway=ingress -register -service ingress-service -address '{{ GetInterfaceIP "eth0" }}:8888' > /tmp/proxy.log 2>&1 &

# Configure hosts to resolv backend.ingress.consul
IGW_IP=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ingress-gw`
echo "${IGW_IP} backend.ingress.consul" >> /etc/hosts

finish

EOFSRSLY

chmod +x /tmp/provision.sh
