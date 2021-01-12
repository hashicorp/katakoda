#!/bin/bash
log() {
  echo "==> $(date) - ${1}"
}
log "Running ${0}"

mkdir -p /etc/consul.d

echo 'bind_addr = "{{GetDefaultInterfaces | sort \"type,size\" | include \"RFC\" \"6890\" | limit 1 | join \"address\" \" \"}}"' | sudo tee /etc/consul.d/network.hcl
echo 'server = true
bootstrap_expect = 1
' | sudo tee /etc/consul.d/server.hcl

systemctl enable consul
systemctl start consul
