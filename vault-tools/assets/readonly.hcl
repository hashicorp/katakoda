# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

path "kv-v1/customers/*" {
  capabilities = ["read", "list"]
}

path "kv-v2/data/customers/*" {
  capabilities = ["read", "list"]
}
