# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# consul-server-one-policy.hcl
node "server-1" {
  policy = "write"
}
node_prefix "" {
   policy = "read"
}
service_prefix "" {
   policy = "read"
}