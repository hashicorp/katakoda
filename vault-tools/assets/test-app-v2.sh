#!/usr/bin/env bash
# Copyright IBM Corp. 2017, 2026
# SPDX-License-Identifier: MPL-2.0


cat <<EOT
Customer info is:

  Organization: ${KV_V2_DATA_CUSTOMERS_ACME_ORGANIZATION}
  ID: ${KV_V2_DATA_CUSTOMERS_ACME_CUSTOMER_ID}
  Contact: ${KV_V2_DATA_CUSTOMERS_ACME_CONTACT_EMAIL}
EOT
