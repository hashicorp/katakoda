```
               __
    ..=====.. |==|     _______________
    ||     || |= |    < Creds,for us! >
 _  ||     || |^*| _   ---------------
|=| o=,===,=o |__||=|
|_|  _______)~`)  |_|
    [=======]  ()
```

Two applications require access access to the API keys stored within Vault.
These secrets are maintained in a KV-v2 secrets engine enabled at the path
`external-apis`. The secret path for `app1` is within the engine at
`app1/socials/twitter`. The secret path for `app2` is within the engine at
`app2/socials/twitter`.  The application `app1` should not havce access to
secrets in `app2`.

Login with the `root` user.

```shell
vault login root
```{{execute}}

Get the secret for `app1`. **This should only be accessible to `app1`.**

```shell
vault kv get external-apis/app1/socials/twitter
```{{execute}}

Get the secret for `app2`. **This should only be accessible to `app2`.**

```shell
vault kv get external-apis/app2/socials/twitter
```{{execute}}

## Enact the policy

The policy should allow `app1` user to only get the `app1` secret and the `app2`
user to only get the `app2` secret.

What policy is required to meet this requirement?

1. Define the policy in the local file.
2. Update the policy named `apps-policy` with an identity template.
3. Test the policy with the `app1` and `app2` users.

<br />

#### 1️⃣ with the CLI flags

Run the command with the `-output-curl-string` flag.

#### 2️⃣ with the audit logs

The last command executed is recorded as the last object:

`cat log/vault_audit.log | jq -s ".[-1].request.path,.[-1].request.operation"`.

### 3️⃣ with the API docs

Read the [Identity
documentation](https://www.vaultproject.io/docs/secrets/identity#token-contents-and-templates).
