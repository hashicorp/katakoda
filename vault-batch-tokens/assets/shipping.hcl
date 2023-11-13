# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

path "secret/data/shipping*" {
   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
