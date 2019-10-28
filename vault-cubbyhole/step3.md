In order for the apps to acquire a valid token to read secrets from `secret/data/dev` path, it must run the unwrap operation using this token.

Use `vault unwrap` command to retrieve the wrapped secrets as follow:

```
vault unwrap <wrapping_token>
```
or
```
VAULT_TOKEN=<wrapping_token> vault unwrap
```
or
```
vault login <wrapping_token>
vault unwrap
```

<br>

Let's unwrap the secret which contains the client token with `apps`. The following command stores the resulting token in `client-token.txt`.

```
vault unwrap -format=json $(cat wrapping-token.txt) \
    | jq -r ".auth.client_token" > client-token.txt
```{{execute T1}}

Log into Vault using the token you just uncovered:

```
vault login $(cat client-token.txt)
```{{execute T1}}


Remember that `apps` policy has a very limited privilege that the policy does not grant permissions on the `secret/data/dev` path other than **read**. Run the following command to verify that you can read the data at `secret/dev`:

```
vault kv get secret/dev
```{{execute T1}}

<br>

## Wrap Any Response

Token is one example.  If you have a user credential stored in Vault and wish to distribute it securely, you can use response wrapping.

Login with root token again:  `vault login root`{{execute T1}}

Write some secrets:

```
vault kv put secret/app_credential user_id="project-admin" password="my-long-password"
```{{execute T1}}

Without response wrapping enabled, you can see the output:

```
vault kv get secret/app_credential
```{{execute T1}}

But when you wrap the `get` response, even you don't see the resulting data from the command invocation. The response from the `vault kv get` operation is placed into the cubbyhole tied to the single use token (`wrapping_token`).  

```
vault kv get -format=json -wrap-ttl=60 secret/app_credential \
     | jq -r ".wrap_info.token" > wrapping-token.txt
```{{execute T1}}

```
vault kv get -wrap-ttl=60 secret/app_credential

Key                              Value
---                              -----
wrapping_token:                  fc76f5e8-f8c4-be9a-50fb-39e5c79676b7
wrapping_accessor:               e39c07b7-71bd-4946-87b3-86302538ac48
wrapping_token_ttl:              1m
wrapping_token_creation_time:    2018-06-08 00:47:43.915339533 +0000 UTC
wrapping_token_creation_path:    secret/data/app_credential
```


Using the `wrapping_token`, you can unwrap the response:

```
vault unwrap -format=json $(cat wrapping-token.txt)
```{{execute T1}}


**NOTE:** If you run the `unwrap` command again, it fails since the `wrapping_token` is a single-use token.  

> Just like any other token, you can revoke `wrapping_token` if you think it was compromised at any time.
