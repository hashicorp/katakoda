Log into Vault using the **initial root token** (`key.txt`{{open}}):

```
vault login $(grep 'Initial Root Token:' key.txt | awk '{print $NF}')
```{{execute T2}}

Audit devices are the components in Vault that keep a detailed log of all requests and response to Vault. Because every operation with Vault is an API request/response, the audit log contains every authenticated interaction with Vault, including errors.


Execute the following command to enable audit logging:

```
vault audit enable file file_path=/var/log/vault-audit.log
```{{execute T2}}

The file audit device writes audit logs to a file (`/var/log/vault-audit.log`). This is a very simple audit device: it appends logs to a file.

> The device does not currently assist with any log rotation. There are very stable and feature-filled log rotation tools already, so we recommend using existing tools.

Each line in the audit log is a JSON object. The type field specifies what type of object it is. Currently, only two types exist: request and response. The line contains all of the information for any given request and response. By default, all the sensitive information is first hashed before logging in the audit logs.

Let's install a JSON format tool, `jq`:

```
apt-get install jq -y
```{{execute T2}}

Now, take a look at the audit log by executing the following command:

```
cat /var/log/vault-audit.log | jq
```{{execute T2}}


Notice that audit logs contain the full request and response objects for every interaction with Vault. The request and response can be matched utilizing a unique identifier assigned to each request. The data in the request and the data in the response (including secrets and authentication tokens) will be hashed with a salt using **HMAC-SHA256**.

```
{
  "time": "2018-06-06T00:07:52.570688813Z",
  "type": "response",
  "auth": {
    "client_token": "hmac-sha256:7f1faa30ae941a21f3705e6796a46ad82a3f8066eb365eb5d35d9a0e1f178ecd",
    "accessor": "hmac-sha256:f0f449772db0c6128c2f940c44f581be34824545b00fec28d2269aa60fa15c37",
    "display_name": "root",
    "policies": [
      "root"
    ],
    ...
```
