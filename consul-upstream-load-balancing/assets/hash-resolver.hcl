# Copyright IBM Corp. 2017, 2026
# SPDX-License-Identifier: MPL-2.0

Kind           = "service-resolver"
Name           = "backend"
LoadBalancer = {
  Policy = "maglev"
  HashPolicies = [
    {
      Field = "header"
      FieldValue = "x-user-id"
    }
  ]
}
