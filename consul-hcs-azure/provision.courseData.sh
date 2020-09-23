cat << 'EOF' > /tmp/provision.sh
#! /bin/bash

log() {
  echo $(date) - ${1}
}

finish() {
  touch /provision_complete
  log "Complete!  Move on to the next step."
}

mkdir -p /tmp/provision

cd /tmp/provision

## ================================
log "Install prerequisites"

apt-get install -y unzip curl > /dev/null

sudo apt-get install jq

## ================================
log "Installing kubectl"

curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

## ================================
log "Installing Helm ${HELM_VERSION}"

export HELM_VERSION="3.2.1"

curl -s https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -o helm-v${HELM_VERSION}-linux-amd64.tar.gz
tar xzf helm-v${HELM_VERSION}-linux-amd64.tar.gz
sudo cp linux-amd64/helm /usr/local/bin/

## ================================
log "Downloading Helm repositories"

helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update

## ================================
log "Cleaning temporary files"

rm -rf /tmp/provision


finish

EOF

chmod +x /tmp/provision.sh
