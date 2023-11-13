# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Get credentials from the database secrets engine
path "database/creds/readonly" {
  capabilities = [ "read" ]
}
