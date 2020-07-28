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

Take a look at the audit log by executing the following command:

```
cat /var/log/vault-audit.log | jq
```{{execute T2}}


Notice that audit logs contain the full request and response objects for every interaction with Vault. The request and response can be matched utilizing a unique identifier assigned to each request. The data in the request and the data in the response (including secrets and authentication tokens) will be hashed with a salt using **HMAC-SHA256**.

```
{
  "time": "2020-07-28T21:38:17.259695614Z",
  "type": "response",
  "auth": {
    "client_token": "hmac-sha256:ac5a3ea6e4c6aa00899164ad7e7bfc66c9e934fb3c9d5f68f063e3e041e82b31",
    "accessor": "hmac-sha256:881d80a80bd3f4ca21ec1a874e161bf04878e8f6e70b868912a0a5a2623e5be0",
    "display_name": "root",
    "policies": [
      "root"
    ],
    "token_policies": [
      "root"
    ],
    ...
```
