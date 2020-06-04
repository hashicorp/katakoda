cat << 'EOFSRSLY' > /tmp/provision.sh
#! /bin/bash

log() {
  echo $(date) - ${@}
}

finish() {
  touch /provision_complete
  log "Complete!  Move on to the next step."
}

#############################

log "Install prerequisites"
# apt-get install -y apt-utils > /dev/null
apt-get install -y unzip curl jq > /dev/null

#############################

log Installing service binaries

mkdir -p ~/src

curl -sL https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/bin/counting-service -o /usr/local/bin/counting-service
curl -sL https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/bin/dashboard-service -o /usr/local/bin/dashboard-service

# cd ~/src && curl -L https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/bin/counting-service -O
# mv ~/src/counting-service /usr/local/bin
# cd ~/src && curl -L https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/bin/dashboard-service -O
# mv ~/src/dashboard-service /usr/local/bin

chmod +x /usr/local/bin/*-service

#############################

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

log Creating Consul user and configuration

useradd consul --create-home
mkdir -p /etc/consul.d

curl -sL https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/config/counting.json -o /etc/consul.d/counting.json
curl -sL https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/config/dashboard.json -o /etc/consul.d/dashboard.json

# cd /etc/consul.d && curl -L https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/config/counting.json -O
# cd /etc/consul.d && curl -L https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/config/dashboard.json -O
mkdir -p /home/consul/log
chown -R consul /home/consul
echo '127.0.0.1 localhost' >> /etc/hosts
runuser -l consul -c "consul agent -dev -client 0.0.0.0 -config-dir=/etc/consul.d >/home/consul/log/consul.log 2>&1 &"

finish

EOFSRSLY

chmod +x /tmp/provision.sh
