# Copyright IBM Corp. 2017, 2023
# SPDX-License-Identifier: MPL-2.0

Kind           = "service-resolver"
Name           = "backend"
LoadBalancer = {
  Policy = "least_request"
  LeastRequestConfig = {
    ChoiceCount = "2"
  }
}