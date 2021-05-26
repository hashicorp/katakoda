## Enact the policy

The app requires the `update` capability for the path
`transit/encrypt/app-auth`.

```hcl
path "transit/encrypt/app-auth" {
  capabilities = [ "update" ]
}
```

Open the `apps-policy.hcl`{{open}} and append the following policies.

<pre class="file" data-filename="apps-policy.hcl" data-target="append">
path "transit/encrypt/app-auth" {
  capabilities = [ "update" ]
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
vault write transit/encrypt/app-auth plaintext=$(base64 <<< "my secret data")
```{{execute}}

Wait until the `apps` user is able to perform every operation successfully.