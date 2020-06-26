Think of a scenario where apps read secrets from Vault. The apps need:

- Policy granting "read" permission on the specific path (`secret/dev`)
- Valid tokens to interact with Vault
- More privileged token (e.g. admin) wraps a secret only the expecting client can read
- The receiving client (an app) unwraps the secret to obtain the token

![Wrapping Token](./assets/vault-cubbyhole.png)

When the response to `vault token create` request is wrapped, Vault inserts the generated token into the _cubbyhole_ of a single-use token, returning that single-use wrapping token. Retrieving the secret requires an `unwrap` operation against this wrapping token.

Since you are currently logged in as a root, you are going to perform the following to demonstrate the apps operations:

1. Create a token with default policy
1. Unwrap the secret to obtain the apps token
1. Verify that you can read `secret/dev` using the apps token
1. Verify that `root` cannot read the cubbyhole secrets written by another token

<br>

To clear the screen: `clear`{{execute T1}}

## Create a New Token for Apps

A policy file (`apps-policy.hcl`) is provided.

```
cat apps-policy.hcl
```{{execute T1}}

This policy grants **read** operation on the `secret/dev` and nothing else.

```
path "secret/data/dev" {
  capabilities = [ "read" ]
}
```

Execute the following command to create a new policy named, `apps-policy`:

```
vault policy write apps apps-policy.hcl
```{{execute T1}}

Also, write some data in `secret/data/dev` for testing:

```
vault kv put secret/dev apikey="1234567890"
```{{execute T1}}

<br>

To create a new token using response wrapping, run the `vault token create` command with `-wrap-ttl` flag:

```
vault token create -policy=<POLICY_NAME> -wrap-ttl=<WRAP_TTL>
```


Execute the following commands to generate a token for apps using response wrapping with TTL of **360 seconds**, and save the generated wrapping token in a file named, `wrapping_token.txt`

```
vault token create -policy=apps -wrap-ttl=360 \
    -format=json | jq -r ".wrap_info.token" > wrapping-token.txt
```{{execute T1}}

> **NOTE:** The response is the **wrapping token** rather than the actual client token for apps-policy; therefore, the admin user does not even see the generated token that he/she generated. After 360 seconds, the wrapping token gets expired that its wrapped content will no longer discoverable.
