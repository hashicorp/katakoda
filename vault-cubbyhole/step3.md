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
```{{execute}}

Log into Vault using the token you just uncovered:

```
vault login $(cat client-token.txt)
```{{execute}}

<br>

Remember that `apps` policy has a very limited privilege that the policy does not grant permissions on the `secret/data/dev` path other than **read**. Run the following command to verify the behavior.

```
vault kv put secret/dev test="secret"
```{{execute}}

You should receive **permission denied** error.

However, the following command should execute successfully:

```
vault kv get secret/dev
```{{execute}}

<br>
