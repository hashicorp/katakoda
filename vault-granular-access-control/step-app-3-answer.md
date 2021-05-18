## Enact the policy

The app requires the `update` capability for the path `transit/encrypt/app-auth`.

```hcl
path "transit/encrypt/app-auth" {
  capabilities = [ "update" ]
}
```

Append the policy definition to the local policy file.

```shell
echo "
path \"transit/encrypt/webapp-auth\" {
  capabilities = [ \"update\" ]
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
vault write transit/encrypt/app-auth plaintext=$(base64 <<< "my secret data")
```{{execute}}

Wait until the `apps` user is able to perform every operation successfully.