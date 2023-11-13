# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

Kind = "ingress-gateway"
Name = "ingress-service"

Listeners = [
 {
   Port = 8080
   Protocol = "http"
   Services = [
     {
       Name = "backend"
       Hosts = ["*"]
     }
   ]
 }
]