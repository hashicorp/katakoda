# Copyright IBM Corp. 2017, 2026
# SPDX-License-Identifier: MPL-2.0

service = {
  name = "backend"
  id = "backend-main"
  port = 9091
  connect = {
    sidecar_service = {}
  }
}