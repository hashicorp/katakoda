## Enact the policy

The app requires the `read` capability for the path `external-apis/data/socials/twitter`.

```hcl
path "external-apis/data/socials/twitter" {
  capabilities = [ "create", "read", "update", "delete" ]
}

path "external-apis/data/socials/+" {
  capabilities = [ "create", "read", "update", "delete" ]
}

path "external-apis/undelete/socials/+" {
  capabilities = [ "update" ]
}
```

Append the policy definition to the local policy file.

```shell
echo "
path \"external-apis/data/socials/twitter\" {
  capabilities = [ \"create\", \"read\", \"update\", \"delete\" ]
}

path \"external-apis/data/socials/+\" {
  capabilities = [ \"create\", \"read\", \"update\", \"delete\" ]
}

path \"external-apis/undelete/socials/+\" {
  capabilities = [ \"update\" ]
}
" >> admins-policy.hcl
```{{execute}}

Update the policy named `admins-policy`.

```shell
vault policy write admins-policy admins-policy.hcl
```{{execute}}

#### Test the policy

Login with the `admins` user.

```shell
vault login -method=userpass \
  username=admins \
  password=admins-password
```{{execute}}

Create a new secret.

```shell
vault kv put \
    external-apis/socials/instagram \
    api_key=hiKD3vMecH2M6t9TTe9kZW \
    api_secret_key=XEkmqo7pc7BaRkCJZ3kwhLM8VKQBFLW7mG7KUjJTyz
```{{execute}}

Update the secret.

```shell
vault kv put \
    external-apis/socials/twitter \
    api_key=hiKD3vMecH2M6t9TTe9kZW \
    api_secret_key=XEkmqo7pc7BaRkCJZ3kwhLM8VKQBFLW7mG7KUjJTyz
```{{execute}}

Delete a secret.

```shell
vault kv delete external-apis/socials/instagram
```{{execute}}

Undelete a secret.

```shell
vault kv undelete -versions=1 external-apis/socials/instagram
```{{execute}}

Wait until the `admins` user is able to perform every operation successfully.
