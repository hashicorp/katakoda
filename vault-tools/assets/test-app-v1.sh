#!/usr/bin/env bash
# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0


cat <<EOT
Customer info is:

  Organization: ${KV_V1_CUSTOMERS_ACME_ORGANIZATION}
  ID: ${KV_V1_CUSTOMERS_ACME_CUSTOMER_ID}
  Contact: ${KV_V1_CUSTOMERS_ACME_CONTACT_EMAIL}
EOT
