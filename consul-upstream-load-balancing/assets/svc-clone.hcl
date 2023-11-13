# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

service = {
  name = "backend"
  id = "backend-clone"
  port = 9092
  connect = {
    sidecar_service = {}
  }
}