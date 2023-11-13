# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

acl = {
    enabled = true
    default_policy = "deny"
    enable_token_persistence = true
    tokens = {
        agent = "${client_token}"
    }
}