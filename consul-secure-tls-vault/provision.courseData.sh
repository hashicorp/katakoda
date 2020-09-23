cat << 'EOFSRSLY' > /tmp/provision.sh
#! /bin/bash

log() {
  echo $(date) - ${@}
}

finish() {
  touch /provision_complete
  log "Complete!  Move on to the next step."
}

# log "Install prerequisites"
# # apt-get install -y apt-utils > /dev/null
# apt-get install -y unzip curl jq > /dev/null

# log Install Consul locally

# # Retrieves lates version from checkpoint
# # Substitute this with APP_VERSION=x.y.z to configure a specific version.
# APP_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/consul | jq .current_version | tr -d '"')

# log Installing Consul ${APP_VERSION}

# curl -s https://releases.hashicorp.com/consul/${APP_VERSION}/consul_${APP_VERSION}_linux_amd64.zip -o consul_${APP_VERSION}_linux_amd64.zip

# unzip consul_${APP_VERSION}_linux_amd64.zip > /dev/null
# chmod +x consul
# mv consul /usr/local/bin/consul

# rm -rf consul_${APP_VERSION}_linux_amd64.zip > /dev/null

# APP_VERSION="0.25.1"


# log Installing consul-template ${APP_VERSION}
# # https://releases.hashicorp.com/consul-template/0.25.1/consul-template_0.25.1_linux_amd64.zip

# curl -s https://releases.hashicorp.com/consul-template/${APP_VERSION}/consul-template_${APP_VERSION}_linux_amd64.zip -o consul-template_${APP_VERSION}_linux_amd64.zip

# unzip consul-template_${APP_VERSION}_linux_amd64.zip > /dev/null
# chmod +x consul-template
# mv consul-template /usr/local/bin/consul-template

# rm -rf consul_${APP_VERSION}_linux_amd64.zip > /dev/null

# log Installing Vault locally

# # Retrieves lates version from checkpoint
# # Substitute this with APP_VERSION=x.y.z to configure a specific version.
# APP_VERSION=$(curl -s https://releases.hashicorp.com/vault/index.json | jq -r '.versions | to_entries[] | .value.version' | sort -r --version-sort | grep -E "[0-9]+\.[0-9]+\.[0-9]+(\.[0-9]+)*$" | head -1)

# log Installing Vault ${APP_VERSION}

# curl -sLf https://releases.hashicorp.com/vault/${APP_VERSION}/vault_${APP_VERSION}_linux_amd64.zip -o vault_${APP_VERSION}_linux_amd64.zip

# unzip vault_${APP_VERSION}_linux_amd64.zip > /dev/null
# chmod +x vault
# mv vault /usr/local/bin/vault

# rm -rf vault_${APP_VERSION}_linux_amd64.zip > /dev/null

# # log Pulling Docker image for Consul ${APP_VERSION}
# # docker pull consul:${APP_VERSION} > /dev/null

# # log Creating Docker volumes
# # docker volume create server_config > /dev/null
# # docker volume create client_config > /dev/null
# # docker container create --name volumes -v server_config:/server -v client_config:/client alpine > /dev/null


finish

EOFSRSLY

chmod +x /tmp/provision.sh
