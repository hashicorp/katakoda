Envconsul launches a subprocess which dynamically populates environment variables from secrets read from Vault. Your applications then read those environment variables. Despite its name, Envconsul does **not** require a Consul cluster to operate. It enables flexibility and portability for applications across systems.

Envconsul has been installed. Execute the following command to check the version:

```
clear
envconsul -v
```{{execute T2}}

Execute the following command to convert the customer data as environment variables:

```
VAULT_TOKEN=$(cat token.txt) envconsul -upcase -secret kv-v1/customers/acme env
```{{execute T2}}

The `-upcase` parameter creates environment variables all in upper case.

Notice that the generated environment variables are named after the secret paths as `KV_V1_CUSTOMERS_ACME_<key>`.

```
...
KV_V1_CUSTOMERS_ACME_ORGANIZATION=ACME Inc.
KV_V1_CUSTOMERS_ACME_REGION=US-West
KV_V1_CUSTOMERS_ACME_TYPE=premium
...
KV_V1_CUSTOMERS_ACME_CUSTOMER_ID=ABXX2398YZPIE7391
KV_V1_CUSTOMERS_ACME_ZIP_CODE=94105
KV_V1_CUSTOMERS_ACME_CONTACT_EMAIL=james@acme.com
...
KV_V1_CUSTOMERS_ACME_STATUS=active
...
```

> **NOTE:** Currently version of Envconsul does not support KV v2, yet.

<br>

View an application script, `test-app.sh`{{open}}

```
clear
chmod 0777 test-app.sh
cat test-app.sh
```{{execute T2}}

Execute the following command to properly populate the script:

```
VAULT_TOKEN=$(cat token.txt) envconsul -upcase -secret kv-v1/customers/acme ./test-app.sh
```{{execute T2}}
