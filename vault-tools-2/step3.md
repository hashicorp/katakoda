Envconsul launches a subprocess which dynamically populates environment variables from secrets read from Vault. Your applications then read those environment variables. Despite its name, Envconsul does **not** require a Consul cluster to operate. It enables flexibility and portability for applications across systems.

> As of [v0.8.0](https://github.com/hashicorp/envconsul/blob/master/CHANGELOG.md), Envconsul supports KV v2 secrets engine. Therefore, if you are using KV v2, you would need Envconsul v0.8.0 or later.

Envconsul has been installed. Execute the following command to check the version:

```
clear
envconsul -v
```{{execute T1}}

Execute the following command to convert the customer data as environment variables:

```
VAULT_TOKEN=$(cat token.txt) envconsul -upcase -secret kv-v1/customers/acme env | grep KV_V1
```{{execute T1}}

The `-upcase` parameter creates environment variables all in upper case.

Notice that the generated environment variables are named after the secret paths as `KV_V1_CUSTOMERS_ACME_<key>`.

```
KV_V1_CUSTOMERS_ACME_CUSTOMER_ID=ABXX2398YZPIE7391
KV_V1_CUSTOMERS_ACME_ORGANIZATION=ACME Inc.
KV_V1_CUSTOMERS_ACME_TYPE=premium
KV_V1_CUSTOMERS_ACME_CONTACT_EMAIL=james@acme.com
KV_V1_CUSTOMERS_ACME_STATUS=active
KV_V1_CUSTOMERS_ACME_ZIP_CODE=94105
KV_V1_CUSTOMERS_ACME_REGION=US-West
```

Now, run the same command against `kv-v2`:

```
VAULT_TOKEN=$(cat token.txt) envconsul -upcase -secret kv-v2/data/customers/acme env | grep KV_V2
```{{execute T1}}

```
KV_V2_DATA_CUSTOMERS_ACME_REGION=US-West
KV_V2_DATA_CUSTOMERS_ACME_STATUS=active
KV_V2_DATA_CUSTOMERS_ACME_TYPE=premium
KV_V2_DATA_CUSTOMERS_ACME_ZIP_CODE=94105
KV_V2_DATA_CUSTOMERS_ACME_CUSTOMER_ID=ABXX2398YZPIE7391
KV_V2_DATA_CUSTOMERS_ACME_CONTACT_EMAIL=james@acme.com
KV_V2_DATA_CUSTOMERS_ACME_ORGANIZATION=ACME Inc.
```

> Notice the difference in the endpoint. To retrieve secrets from `kv-v2`, the endpoint becomes `kv-v2/data/customers/acme`.


<br>

View an application script, `test-app-v1.sh`{{open}} which reads values from environment variables.

```
clear
chmod 0777 test-app-v1.sh
cat test-app-v1.sh
```{{execute T1}}

Execute the following command to properly populate the script:

```
VAULT_TOKEN=$(cat token.txt) envconsul -upcase -secret kv-v1/customers/acme ./test-app-v1.sh
```{{execute T1}}

The `test-app-v2.sh`{{open}} is written for K/V v2.

```
chmod 0777 test-app-v2.sh
VAULT_TOKEN=$(cat token.txt) envconsul -upcase -secret kv-v2/data/customers/acme ./test-app-v2.sh
```{{execute T1}}
