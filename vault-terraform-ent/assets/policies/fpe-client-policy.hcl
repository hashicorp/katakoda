# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# To request data encoding using any of the roles
# Specify the role name in the path to narrow down the scope
path "transform/encode/*" {
   capabilities = [ "update" ]
}

# To request data decoding using any of the roles
# Specify the role name in the path to narrow down the scope
path "transform/decode/*" {
   capabilities = [ "update" ]
}
