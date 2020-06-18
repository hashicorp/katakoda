cat << 'EOFSRSLY' > /tmp/provision.sh
#! /bin/bash

log() {
  echo $(date) - ${1}
}

finish() {
  touch /provision_complete
  log "Complete!  Move on to the next step."
}

log "Installing Helm 3.2.1"

pushd /tmp
curl -s https://get.helm.sh/helm-v3.2.1-linux-amd64.tar.gz -o helm-v3.2.1-linux-amd64.tar.gz
tar xzf helm-v3.2.1-linux-amd64.tar.gz
sudo cp linux-amd64/helm /usr/bin/

finish

EOFSRSLY

chmod +x /tmp/provision.sh
