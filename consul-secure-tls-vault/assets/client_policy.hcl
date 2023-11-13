# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# consul-client-policy.hcl
node_prefix "client-" {
  policy = "write"
}
node_prefix "" {
   policy = "read"
}
service_prefix "" {
   policy = "read"
}