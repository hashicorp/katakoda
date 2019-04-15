Execute the following command to enable the `transit` secrets engine and create a key.

```
vault secrets enable transit
```{{execute T2}}

Create a key named 'autounseal'

```
vault write -f transit/keys/autounseal
```{{execute T2}}

Execute the following file to create `autounseal` policy defined by `autounseal.hcl`{{open}} policy file.

```
vault policy write autounseal autounseal.hcl
```{{execute T2}}

Create a new token with `autounseal` policy attached and save it in a file named, `client_token.txt`.

```
vault token create -policy="autounseal" \
      -format=json | jq -r ".auth.client_token" > client_token.txt
```{{execute T2}}

Set `VAULT_TOKEN` environment variable to the token you just generated.

```
export VAULT_TOKEN="$(cat client_token.txt)"
```{{execute T2}}
