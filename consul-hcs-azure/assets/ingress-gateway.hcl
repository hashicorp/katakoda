# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

Kind = "ingress-gateway"
Name = "ingress-gateway"

Listeners = [
 {
   Port = 8080
   Protocol = "tcp"
   Services = [
     {
       Name = "frontend"
     }
   ]
 }
]