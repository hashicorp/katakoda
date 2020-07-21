```shell-session
sudo systemctl start vault
```{{execute HOST1}}

```shell-session
export VAULT_ADDR='http://0.0.0.0:8200'
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

