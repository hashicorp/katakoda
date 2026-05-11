# Copyright IBM Corp. 2017, 2026
# SPDX-License-Identifier: MPL-2.0

service = {
  name = "backend"
  id = "backend-clone"
  port = 9092
  connect = {
    sidecar_service = {}
  }
}