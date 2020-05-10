To get a new set of PostgreSQL credentials, the client app needs to be able to **read** from the
`readonly` role endpoint. Therefore the app's token must have a policy granting the read permission.

Execute the following policy to create an `apps` policy.

```
vault policy write apps apps-policy.hcl
```{{execute T1}}

Check the `apps` policy.

```
vault policy read apps
```{{execute T1}}

Create a new token with the `apps` policy attached and save it to a file, `app-token.txt`.

```
vault token create -policy="apps" \
    -format=json | jq -r ".auth.client_token" > app-token.txt
```{{execute T1}}

Use the returned token to perform the remaining.

> **NOTE:** [AppRole Pull Authentication](https://learn.hashicorp.com/vault/identity-access-management/approle) guide demonstrates more sophisticated way of generating a token for your apps.

Invoke the vault command with apps token you just generated.

```
VAULT_TOKEN=$(cat app-token.txt) vault read database/creds/readonly
```{{execute T1}}

**Example output:**

```
Key                Value
---                -----
lease_id           database/creds/readonly/qWNtIzzrRjx8PfCXlHeKncCs
lease_duration     1h
lease_renewable    true
password           A1a-pYK1dhXRca5JrlOH
username           v-token-readonly-ZAvB2l7EoCkb9siIVXvf-1589071872
```

The generated dynamic database credentials are referred as **leases** with specific time-to-live (TTL) which is 1 hour for this `readonly` role.

Re-run the command and notice that Vault returns a different set of credentials each time. This means that each app instance can acquire a unique set of DB credentials.

```
VAULT_TOKEN=$(cat app-token.txt) vault read database/creds/readonly
```{{execute T1}}

To find out how many database leases have been created to the `readonly` role, execute the following command.

```
vault list sys/leases/lookup/database/creds/readonly
```{{execute T1}}

**Example output:**

```
Keys
----
0zEHVjk2AELE7FGDIT5WTrBT
qWNtIzzrRjx8PfCXlHeKncCs
```

This example shows that there are two lease IDs: database/creds/readonly/**0zEHVjk2AELE7FGDIT5WTrBT** and database/creds/readonly/**qWNtIzzrRjx8PfCXlHeKncCs** on this Vault server.
