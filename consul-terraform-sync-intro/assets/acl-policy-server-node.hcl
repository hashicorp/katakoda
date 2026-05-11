# Copyright IBM Corp. 2017, 2026
# SPDX-License-Identifier: MPL-2.0

## consul-server-one-policy.hcl
node_prefix "server-" {
  policy = "write"
}