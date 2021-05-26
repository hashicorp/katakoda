## Enact the policy

The app requires the `read` capability for the path
`external-apis/data/socials/twitter` and the path
`external-apis/data/socials/instagram`.

```hcl
path "external-apis/data/socials/twitter" {
  capabilities = [ "read" ]
}

path "external-apis/data/socials/instagram" {
  capabilities = [ "read" ]
}
```

The `+` operator can be used to denote any number of characters bounded within a
single path segment.

```hcl
path "external-apis/data/socials/+" {
  capabilities = [ "read" ]
}
```

Open the `apps-policy.hcl`{{open}} and append the following policies.

<pre class="file" data-filename="apps-policy.hcl" data-target="append">
path "external-apis/data/socials/+" {
  capabilities = [ "read" ]
}
</pre>

Update the policy named `apps-policy`.

```shell
vault policy write apps-policy apps-policy.hcl
```{{execute}}

#### Test the policy

Login with the `apps` user.

```shell
clear
vault login -method=userpass \
  username=apps \
  password=apps-password
```{{execute}}

Get the first secret.

```shell
vault kv get external-apis/socials/twitter
```{{execute}}

Get the second secret.

```shell
vault kv get external-apis/socials/instagram
```{{execute}}

Wait until the `apps` user is able to perform every operation successfully.
