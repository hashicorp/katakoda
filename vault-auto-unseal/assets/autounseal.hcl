# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

path "transit/encrypt/autounseal" {
   capabilities = [ "update" ]
}

path "transit/decrypt/autounseal" {
   capabilities = [ "update" ]
}
