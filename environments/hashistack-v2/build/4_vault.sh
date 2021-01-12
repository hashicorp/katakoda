#!/bin/bash
log() {
  echo "==> $(date) - ${1}"
}
log "Running ${0}"

systemctl enable vault
systemctl start vault
