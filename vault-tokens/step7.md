You learned how you can set the token's lifecycle. The next step is to apply this to generate tokens for your applications. Vault clients first authenticate with Vault using an [**auth method**](https://www.vaultproject.io/docs/auth/index.html) to acquire a token. There are auth methods aimed to authenticate applications or machines. Once its
identity was verified, Vault server will return a token with appropriate policies attached.

Use the AppRole auth method to demonstrate this.

Enable the `approle` auth method.

```
vault auth enable approle
```{{execute T1}}

Create a role for your app specifying that the generated token type is periodic and expires after 24 hours if not renewed.

```
vault write auth/approle/role/jenkins policies="jenkins" period="24h"
```{{execute T1}}

This example defines a role named, "jenkins". The tokens generated for this role will be a periodic token with `jenkins` policy attached.

### Verification

> **NOTE:** If you are not familiar with the AppRole auth method, read the [AppRole Pull Authentication](https://learn.hashicorp.com/tutorials/vault/approle) tutorial.

Retrieve the RoleID for the `jenkins` role and save it in a file, `role_id.txt`.

```
vault read -format=json auth/approle/role/jenkins/role-id \
    | jq -r ".data.role_id" > role_id.txt
```{{execute T1}}

Generate a SecretID for the `jenkins` role and save it in a file, `secret_id.txt`.

```
vault write -f -format=json auth/approle/role/jenkins/secret-id \
    | jq -r ".data.secret_id" > secret_id.txt
```{{execute T1}}

Authenticate with Vault using the generated `role_id` and `secret_id`.

```
vault write -format=json auth/approle/login role_id=$(cat role_id.txt) \
     secret_id=$(cat secret_id.txt) \
     | jq -r ".auth.client_token" > jenkins-token.txt
```{{execute T1}}

View the token details.

```
vault token lookup $(cat jenkins-token.txt)
```{{execute T1}}

The output shows the `period` of 24 hours, and the `jenkins` policy is attached.
