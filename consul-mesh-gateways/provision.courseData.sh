cat << 'EOFSRSLY' > /tmp/provision.sh
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

export HELM_VERSION="3.2.1"

log "Installing Helm ${HELM_VERSION}"

curl -s https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -o helm-v${HELM_VERSION}-linux-amd64.tar.gz
tar xzf helm-v${HELM_VERSION}-linux-amd64.tar.gz
sudo cp linux-amd64/helm /usr/local/bin/

## ================================

export KUBECTL_VERSION=`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`

log "Installing Kubectl ${KUBECTL_VERSION}"

curl -sLO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl

chmod +x ./kubectl

mv ./kubectl /usr/local/bin/kubectl

## ================================

export SHIPYARD_VERSION="0.0.33"

log "Installing Shipyard ${SHIPYARD_VERSION}"

curl -Ls https://github.com/shipyard-run/shipyard/releases/download/v${SHIPYARD_VERSION}/shipyard_${SHIPYARD_VERSION}_Linux_x86_64.tar.gz -o shipyard_${SHIPYARD_VERSION}_Linux_x86_64.tar.gz

tar xzf shipyard_${SHIPYARD_VERSION}_Linux_x86_64.tar.gz

mv ./shipyard /usr/local/bin/shipyard

## ================================

log "Running Scenario"

cd ~

shipyard run ./cluster-blueprint/

# log "Adding lab users"

# useradd dc1 --create-home -G docker -s /bin/bash
# cp /root/dc1-values.yml /home/dc1
# chown dc1: /home/dc1/*.yml

# useradd dc2 --create-home -G docker -s /bin/bash
# cp /root/dc2-values.yml /home/dc2
# chown dc2: /home/dc2/*.yml

# log "Starting first Kubernetes cluster...this might take up to 5 minutes."

# curl https://shipyard.run/blueprint | bash -s github.com/shipyard-run/blueprints//learn-consul-service-mesh

# runuser -l consul -c "minikube start --vm-driver=docker -p dc1 -v 8 --memory 1024"

# log "Starting second Kubernetes cluster...this might take up to 5 minutes."

# runuser -l consul -c "minikube start --vm-driver=docker -p dc2 -v 8 --memory 1024"

# # minikube start --wait=true

# # log "Installing Consul service mesh."

# # helm repo add hashicorp https://helm.releases.hashicorp.com

# # helm install -f ~/consul-values.yml hashicorp hashicorp/consul

# # log "Waiting for Consul pod to complete configuration."
# # until [ `kubectl get pods | grep consul-server | grep Running | wc -l` -gt 0 ]
# # do
# #   sleep 5
# # done

# # log "Adding port forward for Consul UI"

# # export IP_ADDR=$(hostname -I | awk '{print $1}')

# # kubectl port-forward service/hashicorp-consul-ui 80:80 --address ${IP_ADDR} &

# # log "Deploying api backend."

# # kubectl apply -f ~/api.yml

# # log "Deploying web backend"

# # kubectl apply -f ~/web.yml

# # log "Waiting for deployment to complete"

# # until [ `kubectl get pods | grep -E "(web-|api-)deployment" | grep Running | wc -l`  -gt 1 ]
# # do
# #   sleep 5
# # done

# # log "Adding port forward for Web UI"

# # export IP_ADDR=$(hostname -I | awk '{print $1}')

# # kubectl port-forward service/web 9090:9090 --address ${IP_ADDR} &

## ================================

log "Cleaning temporary files"

rm -rf /tmp/provision


finish

EOFSRSLY

chmod +x /tmp/provision.sh
