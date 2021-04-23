Start the Vault server.

```shell-session
vault server -dev -dev-root-token-id=root -dev-listen-address=0.0.0.0:8200 &
```{{execute HOST1}}

Export an environment variable for the `vault` CLI to address the Vault server.

```shell-session
export VAULT_ADDR='http://0.0.0.0:8200'
```{{execute HOST1}}

Login as a highly privileged user.

```shell-session
vault login root
```{{execute HOST1}}

Enable the SSH secrets engine.

```shell-session
vault secrets enable ssh
```{{execute HOST1}}

Create a role named `otp_key_role` with `key_type` set to `otp`.

```shell-session
vault write ssh/roles/otp_key_role key_type=otp \
      default_user=ubuntu \
      cidr_list=0.0.0.0/0
```{{execute HOST1}}
