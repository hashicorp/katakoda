# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Request OpenLDAP credential from the learn role
path "openldap/static-cred/learn" {
  capabilities = [ "read" ]
}