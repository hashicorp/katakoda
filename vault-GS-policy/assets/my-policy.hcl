# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Dev servers have version 2 of KV secrets engine mounted by default, so will
# need these paths to grant permissions:
path "secret/data/*" {
  capabilities = ["create", "update"]
}

path "secret/data/foo" {
  capabilities = ["read"]
}
