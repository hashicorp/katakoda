# Copyright IBM Corp. 2017, 2023
# SPDX-License-Identifier: MPL-2.0

acl = {
    enabled = true
    default_policy = "deny"
    enable_token_persistence = true
    tokens = {
        agent = "${client_token}"
    }
}