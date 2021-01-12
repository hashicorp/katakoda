#!/bin/bash
log() {
  echo "==> $(date) - ${1}"
}
log "Running ${0}"

## Docker installation
install_docker()
{
sudo apt-get update -y
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo systemctl enable docker
}

if [ "${FROMDOCKER}" == "1" ]
then
  install_docker
fi
