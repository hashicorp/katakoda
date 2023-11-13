#!/bin/bash
# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

log() {
  echo "==> $(date) - ${1}"
}
log "Running ${0}"

systemctl enable vault
systemctl start vault
