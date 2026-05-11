# Copyright IBM Corp. 2017, 2026
# SPDX-License-Identifier: MPL-2.0

service = {
  name = "client"
  connect = {
    sidecar_service = {
      proxy = {
        upstreams = [
          {
            destination_name = "backend"
            local_bind_port = 9192
          }
        ]
      }
    }
  }
}