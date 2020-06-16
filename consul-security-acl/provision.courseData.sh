cat << 'EOF' > /tmp/provision.sh
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

log Install Consul locally

# Retrieves lates version from checkpoint
# Substitute this with APP_VERSION=x.y.z to configure a specific version.
APP_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/consul | jq .current_version | tr -d '"')

log Installing Consul ${APP_VERSION}

curl -s https://releases.hashicorp.com/consul/${APP_VERSION}/consul_${APP_VERSION}_linux_amd64.zip -o consul_${APP_VERSION}_linux_amd64.zip

unzip consul_${APP_VERSION}_linux_amd64.zip > /dev/null
chmod +x consul
mv consul /usr/local/bin/consul

rm -rf consul_${APP_VERSION}_linux_amd64.zip > /dev/null

log Pulling Docker image for Consul ${APP_VERSION}

docker pull consul:${APP_VERSION} > /dev/null

log Creating Docker volumes

docker volume create server_config > /dev/null

docker volume create client_config > /dev/null

docker container create --name volumes -v server_config:/server -v client_config:/client alpine > /dev/null

finish

EOF

chmod +x /tmp/provision.sh
