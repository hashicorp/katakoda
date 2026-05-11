# Copyright IBM Corp. 2017, 2026
# SPDX-License-Identifier: MPL-2.0

path "secret/data/training*" {
   capabilities = ["create", "read", "update", "delete", "list"]
}

path "secret/*" {
   capabilities = ["list"]
}
