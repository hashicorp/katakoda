# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

disable_mlock = true
ui=true

storage "file" {
  path = "~/vault-1/data"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}
