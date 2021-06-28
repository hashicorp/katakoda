First, login with root token.

```
vault login root
```{{execute T1}}

The policy format uses a prefix matching system on the API path to determine
access control. The most specific defined policy is used, either an exact match
or the longest-prefix glob match. Since everything in Vault must be accessed via
the API, this gives strict control over every aspect of Vault, including
enabling secrets engines, enabling auth methods, authenticating, as well as
secret access.

Open the example policy, `my-policy.hcl`{{open}}

With this policy, a user could write any secret to `secret/data/`, except to `secret/data/foo`, where only read access is allowed. Policies default to deny, so any access to an unspecified path is not allowed.

To write a policy using the command line, specify the path to a policy file to upload.

```
vault policy write my-policy my-policy.hcl
```{{execute T1}}

To list all policies, execute the following command.

```
vault policy list
```{{execute T1}}

To view the contents of a policy, execute the `vault policy read` command.

```
vault policy read my-policy
```{{execute T1}}

<br />

## Testing the Policy

First, check to verify that KV v2 secrets engine has not been enabled at `secret/`.

```
vault secrets list | grep 'secret/'
```{{execute T1}}

If this command produces no output (i.e. secret/ is not listed), enable the secrets engine before proceeding, otherwise skip this step.

```
vault secrets enable -path=secret/ kv-v2
```{{execute T1}}

To use the policy, create a token and assign it to that policy.

```
vault token create -field=token -policy=my-policy > token.txt
```{{execute T1}}

Use the generated token value to authenticate with Vault.

```
vault login $(cat token.txt)
```{{execute T1}}

Verify that you can write any data to `secret/data/`.

> **NOTE:** When you access the [KV v2 secrets engine](https://www.vaultproject.io/docs/secrets/kv/kv-v2/) using the `vault kv` CLI commands, `/data` will be automatically appended to the secret path, so you should omit it.

```
vault kv put secret/creds password="my-long-password"
```{{execute T1}}

Since `my-policy` only permits read from the `secret/data/foo` path, any attempt to write **fails** with "permission denied" error.

```
vault kv put secret/foo robot=beepboop
```{{execute T1}}

You also do not have access to `sys` according to the policy, so commands like `vault policy list` or `vault secrets list` will not work.
