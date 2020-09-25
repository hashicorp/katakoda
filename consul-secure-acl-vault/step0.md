
The Consul secret engine generates Consul tokens dynamically based on Consul ACL policies.

## Start Vault

First, create a directory to store the logging output of the Vault server.

`mkdir -p /opt/vault/logs`{{execute T1}}

Next, start the Vault server. 

`nohup sh -c "vault server -dev -dev-root-token-id="root" -dev-listen-address=0.0.0.0:8200 >/opt/vault/logs/vault.log 2>&1" > /opt/vault/logs/nohup.log &`{{execute T1}}

Finally, to communicate with the Vault server you will need to set the address and token. 

`export VAULT_ADDR='http://127.0.0.1:8200'`{{execute T1}}

`export VAULT_TOKEN="root"`{{execute T1}}

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px;">
  <p><strong>Warning: </strong>
  This lab launches Vault in dev mode. This is not suggested for production.
</p></div>
