# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Use Vault provider
provider "vault" {
  # It is strongly recommended to configure this provider through the
  # environment variables:
  #    - VAULT_ADDR
  #    - VAULT_TOKEN
  #    - VAULT_CACERT
  #    - VAULT_CAPATH
  #    - etc.
}
