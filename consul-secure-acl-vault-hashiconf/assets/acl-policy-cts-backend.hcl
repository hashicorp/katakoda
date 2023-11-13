# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

// Consul KV backend default prefix for state files
key_prefix "consul-terraform-sync/" {
  policy = "write"
}

session_prefix "" {
  policy = "write"
}