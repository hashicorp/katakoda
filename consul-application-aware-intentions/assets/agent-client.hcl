# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

// connect {
//   enabled = true
// }

ports {
  grpc = 8502
}

enable_central_service_config = true

data_dir = "/tmp/consul"