# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

Kind           = "service-resolver"
Name           = "backend"
LoadBalancer = {
  Policy = "least_request"
  LeastRequestConfig = {
    ChoiceCount = "2"
  }
}