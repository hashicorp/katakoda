```shell-session
vault status
```{{execute HOST1}}

```shell-session
vault server -dev -dev-root-token-id root -dev-listen-address=0.0.0.0:8200
```{{execute T3}}

```shell-session
vault server -dev -dev-root-token-id root -dev-listen-address=0.0.0.0:8200
```{{execute T4}}

```shell-session
export VAULT_ADDR='http://0.0.0.0:8200'
```{{execute HOST1}}

```shell-session
ufw allow 8200/tcp
```{{execute HOST1}}

```shell-session
vault login root
```{{execute HOST1}}

```shell-session
vault secrets enable ssh
```{{execute HOST1}}

Next, create a role.

```shell-session
vault write ssh/roles/otp_key_role key_type=otp \
      default_user=ubuntu \
      cidr_list=0.0.0.0/0
```{{execute HOST1}}

