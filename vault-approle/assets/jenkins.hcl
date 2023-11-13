# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Read-only permission on 'secret/data/myapp/*' path
path "secret/data/myapp/*" {
  capabilities = [ "read" ]
}
