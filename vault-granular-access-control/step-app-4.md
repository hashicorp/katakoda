```
               __
    ..=====.. |==|     _______________
    ||     || |= |    < Instagram, plz! >
 _  ||     || |^*| _   ---------------
|=| o=,===,=o |__||=|
|_|  _______)~`)  |_|
    [=======]  ()
```

The application requires access another API keys stored within Vault. These
secrets are maintained in a KV-V2 secrets engine enabled at the path
`external-apis`. The secret path within the engine is `socials/twitter` and
`socials/instagram`.

Login with the `root` user.

```shell
vault login root
```{{execute}}

Get the first secret.

```shell
vault kv get external-apis/socials/twitter
```{{execute}}

Get the second secret.

```shell
vault kv get external-apis/socials/instagram
```{{execute}}

## Enact the policy

The policies defined for `apps` grants it the capability to perform the first
but not the second operation.

What policy is required to meet this requirement?

1. Define the policy in the local file.
2. Update the policy named `apps-policy` to use `+` or `*` operator.
3. Test the policy with the `apps` user.


<br />

#### 1️⃣ with the CLI flags

Run the command with the `-output-curl-string` flag.

#### 2️⃣ with the audit logs

The last command executed is recorded as the last object:

`cat log/vault_audit.log | jq -s ".[-1].request.path,.[-1].request.operation"`.

### 3️⃣ with the API docs

Select the KV-V2 API tab to read the [KV-V2 API
documentation](https://www.vaultproject.io/api-docs/secret/kv/kv-v2).
