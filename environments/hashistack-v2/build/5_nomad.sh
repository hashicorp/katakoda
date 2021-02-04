#!/bin/bash
log() {
  echo "==> $(date) - ${1}"
}
log "Running ${0}"

raw_exec_nomad() {
  mkdir -p /etc/nomad.d
  echo '
plugin "raw_exec" {
  config {
    enabled = true
  }
}
' | sudo tee /etc/nomad.d/raw_exec.hcl
}

telemetry_nomad() {
  mkdir -p /etc/nomad.d
  echo '
telemetry {
  publish_allocation_metrics = true
  publish_node_metrics       = true
  prometheus_metrics         = true
}
' | sudo tee /etc/nomad.d/telemetry.hcl
}

raw_exec_nomad
telemetry_nomad

systemctl enable nomad
systemctl start nomad
