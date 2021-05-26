## Enact the policy

The app requires the `read` capability for the path
`external-apis/data/{{identity.entity.name}}/socials/+`.

The `{{identity.entity.name}}` template can be used to denote the name of
entity.

```hcl
path "external-apis/data/{{identity.entity.name}}/socials/+" {
  capabilities = [ "read" ]
}
```

Open the `apps-policy.hcl`{{open}} and append the following policies.

<pre class="file" data-filename="apps-policy.hcl" data-target="append">
path "external-apis/data/{{identity.entity.name}}/socials/+" {
  capabilities = [ "read" ]
}
</pre>

Update the policy named `apps-policy`.

```shell
vault policy write apps-policy apps-policy.hcl
```{{execute}}

#### Test the policy

Login with the `app1` user.

```shell
clear
vault login -method=userpass \
  username=app1 \
  password=app1-password
```{{execute}}

Get the `app1` secret.

```shell
vault kv get external-apis/app1/socials/twitter
```{{execute}}

Fail to get the `app2` secret.

```shell
vault kv get external-apis/app2/socials/twitter
```{{execute}}

Login with the `app2` user.

```shell
vault login -method=userpass \
  username=app2 \
  password=app2-password
```{{execute}}

Fail to get the `app1` secret.

```shell
vault kv get external-apis/app1/socials/twitter
```{{execute}}

Get the `app2` secret.

```shell
vault kv get external-apis/app2/socials/twitter
```{{execute}}


Wait until the users are able to perform every operation as expected.
