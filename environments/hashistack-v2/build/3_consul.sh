#!/bin/bash
log() {
  echo "==> $(date) - ${1}"
}
log "Running ${0}"

# Handle 
fix_docker() {
  mkdir -p /etc/consul.d
  if [[ "${FROMDOCKER}" != "1" ]]
  then
    log "Running Docker Fixups"
    rm /etc/consul.d/network.hcl
  fi
}

echo '#bind_addr = "{{GetInterfaceIP \"eth0\"}}"
bind_addr = "{{GetDefaultInterfaces | sort \"type,size\" | include \"RFC\" \"6890\" | limit 1 | join \"address\" \" \"}}"
' | sudo tee /etc/consul.d/network.hcl

echo 'server = true
bootstrap_expect = 1
' | sudo tee /etc/consul.d/server.hcl

systemctl enable consul
fix_docker

