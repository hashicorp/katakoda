Once the key is stored in Vault, you can retrieve it
from any machine that has access to Vault.

From your Consul server node, use the `vault kv get`
command using the `-field` parameter to retrieve the
key value only.

`vault kv get -field=key kv-v2/consul/config/encryption | tee encryption.key`{{execute}}

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px;">
  <p><strong>Warning: </strong>

  The command relies on the presence of `VAULT_ADDR` and `VAULT_TOKEN` in your environment variables to define Vault address and user token respectively. In this scenario, these variables were defined right after the Vault process started with:
  * `export VAULT_ADDR='http://127.0.0.1:8200'`
  * `export VAULT_TOKEN="root"`

  If you want to apply this scenario to your own dev environment,
  you will need a dedicated node for Vault and should modify the
  `VAULT_ADDR` variable to reflect the actual address of your
  Vault cluster.

  The same principle applies to the `VAULT_TOKEN` environment variable
  that will need to contain a valid token for your Vault instance.

</p></div>





