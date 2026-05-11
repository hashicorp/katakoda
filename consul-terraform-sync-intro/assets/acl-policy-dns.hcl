# Copyright IBM Corp. 2017, 2026
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