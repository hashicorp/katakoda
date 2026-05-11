#!/bin/bash
# Copyright IBM Corp. 2017, 2026
# SPDX-License-Identifier: MPL-2.0

log() {
  echo "==> $(date) - ${1}"
}
log "Running ${0}"

systemctl enable vault
systemctl start vault
