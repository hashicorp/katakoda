To get a new set of PostgreSQL credentials, the client app needs to be able to **read** from the
`readonly` role endpoint. Therefore the app's token must have a policy granting the read permission.

Execute the following policy to create an `apps` policy.

```
vault policy write apps apps-policy.hcl
```{{execute T1}}

Create a new token with the `apps` policy attached and save it to a file, `app-token.txt`.

```
vault token create -policy="apps" \
    -format=json | jq -r ".auth.client_token" > app-token.txt
```{{execute T1}}

Use the returned token to perform the remaining.

-> **NOTE:** [AppRole Pull Authentication](https://learn.hashicorp.com/vault/identity-access-management/approle) guide demonstrates more sophisticated way of generating a token for your apps.

Invoke the vault command with apps token you just generated.

```
VAULT_TOKEN=$(cat app-token.txt) vault read database/creds/readonly
```{{execute T1}}

Re-run the command and notice that Vault returns a different set of credentials each time. This means that each app instance can acquire a unique set of DB credentials.


Re-run the command and notice that Vault returns a different set of credentials each time. This means that each app instance can acquire a unique set of DB credentials.

```
VAULT_TOKEN=$(cat app-token.txt) vault read database/creds/readonly
```{{execute T1}}
