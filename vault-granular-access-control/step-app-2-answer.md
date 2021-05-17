## Enact the policy

The app requires ...

```hcl
path "" {
  capabilities = [ "" ]
}
```

Append the policy definition to the local policy file.

```shell
echo "
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
vault ...
```{{execute}}

The policy enables the `apps` user to get the secret.