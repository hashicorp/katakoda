#!/bin/bash
log() {
  echo "==> $(date) - ${1}"
}
log "Running ${0}"

# Handle 
fix_docker()
{
if [[ "${FROMDOCKER}" != "1" ]]
then
  log "Running Docker Fixups"
  rm /etc/consul.d/network.hcl
fi
}

echo 'bind_addr = "{{GetInterfaceIP \"ens3\"}}"' | sudo tee /etc/consul.d/network.hcl
fix_docker

