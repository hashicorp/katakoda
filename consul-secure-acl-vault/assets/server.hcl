# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Base configuration
data_dir = "/opt/consul/data",
log_level = "INFO",
node_name = "server-1",
server = true,
ui = true,
client_addr = "0.0.0.0",
advertise_addr = "{{ GetInterfaceIP \"ens3\" }}",
bootstrap_expect = 1,

# ACL configuration
acl = {
    enabled = true
    default_policy = "deny"
    enable_token_persistence = true
}