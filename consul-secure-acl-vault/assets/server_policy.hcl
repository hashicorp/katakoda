# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# consul-server-policy.hcl
node_prefix "server-" {
  policy = "write"
}
node_prefix "" {
   policy = "read"
}
service_prefix "" {
   policy = "read"
}