# Copyright IBM Corp. 2017, 2023
# SPDX-License-Identifier: MPL-2.0

# Get credentials from the azure secrets engine
path "azure/creds/edu-app" {
  capabilities = [ "read" ]
}
