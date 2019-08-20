#!/usr/bin/env bash

cat <<EOT
Customer info is:

  Organization: ${KV_V1_CUSTOMERS_ACME_ORGANIZATION}
  ID: ${KV_V1_CUSTOMERS_ACME_CUSTOMER_ID}
  Contact: ${KV_V1_CUSTOMERS_ACME_CONTACT_EMAIL}
EOT
