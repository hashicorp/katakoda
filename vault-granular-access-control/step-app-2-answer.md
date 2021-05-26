## Enact the policy

The app requires the `read` capability for the path `database/creds/readonly`.

```hcl
path "database/creds/readonly" {
  capabilities = [ "read" ]
}
```

Open the `apps-policy.hcl`{{open}} and append the following policies.

<pre class="file" data-filename="apps-policy.hcl" data-target="append">
path "database/creds/readonly" {
  capabilities = [ "read" ]
}
</pre>

Update the policy named `apps-policy`.

```shell
vault policy write apps-policy apps-policy.hcl
```{{execute}}

## Test the policy

Login with the `apps` user.

```shell
clear
vault login -method=userpass \
  username=apps \
  password=apps-password
```{{execute}}

Get the secret.

```shell
vault read database/creds/readonly
```{{execute}}

Wait until the `apps` user is able to perform every operation successfully.