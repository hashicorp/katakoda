# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

## Wide Policy for service registration
service_prefix "" {
  policy = "write"
}

node_prefix "" {
  policy = "read"
}