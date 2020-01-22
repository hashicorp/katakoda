Consul Template tool itself is a Vault client. Therefore it must have a valid token with policies permitting it to retrieve secrets from KV secrets engine. So, first, you need to create a policy allowing Consul Template to read from `kv-v1` and `kv-v2` paths.


## Generate a Client Token

Policy file has been provided: `readonly.hcl`{{open}}

Create a policy named, `readonly`:

```
vault policy write readonly readonly.hcl
```{{execute T1}}

Now, execute the following command to generate a client token for Consul Template to use and save the generated token in `token.txt` file:

```
vault token create -policy=readonly -ttl=1h \
      -format=json | jq -r ".auth.client_token" > token.txt
```{{execute T1}}

This token is valid for 1 hour, and `readonly` policy is attached.

```
clear
vault token lookup $(cat token.txt)
```{{execute T1}}

<br>

## Write Template Files

Assume that your application needs to retrieve `organization`, `customer_id` and `contact_email` of the customer data from KV secrets engine.

To have Consul Template to populate those values, you need to create a **template file** with Consul Template [templating language](https://github.com/hashicorp/consul-template#templating-language).

You need to create a template file using Consul Template syntax so that the values will be retrieved from Vault. Open the `customer-v1.tpl`{{open}} file and enter the following:

<pre class="file" data-filename="customer-v1.tpl" data-target="replace">
{{ with secret "kv-v1/customers/acme" }}
Organization: {{ .Data.organization }}
ID: {{ .Data.customer_id }}
Contact: {{ .Data.contact_email }}
{{ end }}
</pre>

This template file will be used to retrieve data from `kv-v1`.

> As of [v0.20.0](https://github.com/hashicorp/consul-template/blob/v0.20.0/CHANGELOG.md), Consul Template supports KV v2 secrets engine. Therefore, if you are using KV v2, you would need Consul Template 0.20.0 or later.

Open the `customer-v2.tpl`{{open}} file and enter the following:

<pre class="file" data-filename="customer-v2.tpl" data-target="replace">
{{ with secret "kv-v2/data/customers/acme" }}
Organization: {{ .Data.data.organization }}
ID: {{ .Data.data.customer_id }}
Contact: {{ .Data.data.contact_email }}
{{ end }}
</pre>

Notice the difference. In `customer-v2.tpl`, the path contains `data` (`kv-v2/data/customers/acme`). This is because the API endpoint to interact with KV version 1 and version 2 are slightly different. Read the [KV v2 documentation](https://www.vaultproject.io/api/secret/kv/kv-v2.html#read-secret-version) for more detail.

If you wish to always read a specific version of the `kv-v2/customer/acme`, you can hard-set the version by setting the path to `kv-v2/data/customers/acme?version=1`.

<br>

## Run Consul Template

Consul Template has been installed. Execute the following command to check the version:

```
consul-template -v
```{{execute T1}}

Let's run Consul Template against `kv-v1`:

```
VAULT_TOKEN=$(cat token.txt) consul-template -template=customer-v1.tpl:customer-v1.txt -once
```{{execute T1}}

Verify that the secrets were retrieved successfully: `customer-v1.txt`{{open}}



Now, run Consul Template against `kv-v2`:

```
VAULT_TOKEN=$(cat token.txt) consul-template -template=customer-v2.tpl:customer-v2.txt -once
```{{execute T1}}

Verify that the secrets were retrieved successfully: `customer-v2.txt`{{open}}
