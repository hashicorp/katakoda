# Copyright (c) HashiCorp, Inc.
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
