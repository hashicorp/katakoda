You've learned how you can fine tune the token's lifecycle. Now, let's talk
about tokens for your applications. Vault clients first authenticate with Vault
using an [**auth method**](https://www.vaultproject.io/docs/auth/index.html) to
acquire a token.

There are auth methods aimed to authenticate applications or machines. Once its
identity was verified, Vault server will return a token with appropriate
policies attached.

Let's talk about [AppRole](https://learn.hashicorp.com/vault/developer/iam-authentication) auth method configuration.

## Generate batch tokens with AppRole

First, enable the `approle` auth method first.

```
vault auth enable approle
```{{execute T1}}

Let's create a policy named, `shipping` (`shipping.hcl`{{open}}).

```
vault policy write shipping shipping.hcl
```{{execute T1}}

Now configure the `approle` auth method to generate a batch token for your app:

```
vault write auth/approle/role/shipping token_policies="shipping" token_ttl="20m" \
      token_type="batch"         
```{{execute T1}}

This example defines a role named, "shipping". The tokens generated for this
role  will be a batch token with TTL of 20 minutes.


## Verification

Let's try to make sure that the `approle` will generate batch tokens for role,
**shipping**.

Execute the following command to generate the role ID:

```
vault read -format=json auth/approle/role/shipping/role-id \
      | jq -r ".data.role_id" > role_id.txt
```{{execute T1}}

Execute the following command to generate the secret ID:

```
vault write -f -format=json auth/approle/role/shipping/secret-id \
      | jq -r ".data.secret_id" > secret_id.txt
```{{execute T1}}

Now, let's login:

```
vault write -format=json auth/approle/login \
      role_id=$(cat role_id.txt) secret_id=$(cat secret_id.txt) \
      | jq -r ".auth.client_token" > app_token.txt
```{{execute T1}}

Upon a successful authentication, Vault generates a client token which is now stored in the `app_token.txt`{{open}} file.

Let's lookup the token's properties:

```
vault token lookup $(cat app_token.txt)
```{{execute T1}}

The generated tokens **type** should be `batch` with TTL of 20 minutes.
