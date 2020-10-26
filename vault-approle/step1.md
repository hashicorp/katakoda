Before begin, login with Vault using a root token.

```
vault login root
```{{execute T1}}

A policy file, `jenkins.hcl`{{open}} is provided. This policy grants read-only permission on the `secret/data/myapp/*` path. Execute the following command to create a policy named, `jenkins`.

```
vault policy write jenkins jenkins.hcl
```{{execute T1}}

Create some test data at `secret/myapp/db-config`:

```
vault kv put secret/myapp/db-config @data.json
```{{execute T1}}

Verify to see that test data was successfully created:

```
vault kv get secret/myapp/db-config
```{{execute T1}}

<br>

## Setup AppRole

For the purpose of introducing the basics of AppRole, this guide walks you through a very simple scenario involving only two personas (admin and app).

![](./assets/vault-approle-workflow.png)

Execute the following command to enable the `approle` auth method:

```
vault auth enable approle
```{{execute T1}}

This enables the `approle` at the `approle/` path.

```
vault auth list
```{{execute T1}}

Create a role named `jenkins` with `jenkins` policy attached. (NOTE: This example creates a role which operates in [**pull**
mode](https://www.vaultproject.io/docs/auth/approle.html).)

```
vault write auth/approle/role/jenkins token_policies="jenkins" \
      token_ttl=1h token_max_ttl=4h
```{{execute T1}}

To view the `jenkins` role details:

```
vault read auth/approle/role/jenkins
```{{execute T1}}

```
Key                        Value
---                        -----
...
token_max_ttl              4h
token_no_default_policy    false
token_num_uses             0
token_period               0s
token_policies             [jenkins]
token_ttl                  1h
token_type                 default
```

When a client authenticates as `jenkins` role, the generated client token has a time-to-live (TTL) of 1 hour and it can be renewed for up to 4 hours of its first creation.
