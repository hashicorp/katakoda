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

## ================================
log "Installing kubectl"

curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

## ================================
log "Installing kind"

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.8.1/kind-$(uname)-amd64
chmod +x ./kind
mv ./kind /usr/local/bin/kind

kind create cluster --name l7

## ================================
log "Installing Helm ${HELM_VERSION}"

export HELM_VERSION="3.2.1"

curl -s https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -o helm-v${HELM_VERSION}-linux-amd64.tar.gz
tar xzf helm-v${HELM_VERSION}-linux-amd64.tar.gz
sudo cp linux-amd64/helm /usr/local/bin/

## ================================
log "Downloading Helm repositories"

helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update

## ================================
log "Cleaning temporary files"

rm -rf /tmp/provision


finish

EOF

chmod +x /tmp/provision.sh
