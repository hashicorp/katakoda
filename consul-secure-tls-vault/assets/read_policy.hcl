# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# read-only-policy.hcl
node_prefix "" {
   policy = "read"
}
service_prefix "" {
   policy = "read"
}
key-prefix "" {
   policy = "read"
}