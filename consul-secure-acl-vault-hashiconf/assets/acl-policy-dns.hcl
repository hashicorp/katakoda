# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

## dns-request-policy.hcl
node_prefix "" {
  policy = "read"
}
service_prefix "" {
  policy = "read"
}
# only needed if using prepared queries
query_prefix "" {
  policy = "read"
}