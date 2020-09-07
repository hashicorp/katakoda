#!/bin/bash
log() {
  echo "==> $(date) - ${1}"
}
log "Running ${0}"

raw_exec_nomad()
{
echo '
plugin "raw_exec" {
  config {
    enabled = true
  }
}
' | sudo tee /etc/nomad.d/raw_exec.hcl
}

raw_exec_nomad
