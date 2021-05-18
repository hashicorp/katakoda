## Enact the policy

The app requires the `read` capability for the path `database/creds/readonly`.

```hcl
path "database/creds/readonly" {
  capabilities = [ "read" ]
}
```

Append the policy definition to the local policy file.

```shell
echo "
path \"database/creds/readonly\" {
  capabilities = [ \"read\" ]
}
" >> apps-policy.hcl
```{{execute}}

Update the policy named `apps-policy`.

```shell
vault policy write apps-policy apps-policy.hcl
```{{execute}}

## Test the policy

Login with the `apps` user.

```shell
vault login -method=userpass \
  username=apps \
  password=apps-password
```{{execute}}

Get the secret.

```shell
vault read database/creds/readonly
```{{execute}}

The policy enables the `apps` user to get the database credentials.