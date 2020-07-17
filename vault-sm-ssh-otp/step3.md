The client must have permissions against the `ssh/creds/otp_key_role` path to
request an OTP for `otp_key_role`. First, create a policy file named,
`test.hcl`.

```shell-session
tee test.hcl <<EOF
path "ssh/creds/otp_key_role" {
  capabilities = ["create", "read", "update"]
}
EOF
```{{execute HOST01}}

Create a `test` policy on the Vault server.

```shell-session
vault policy write test ./test.hcl
```{{execute HOST01}}

For this guide, enable the `userpass` auth method and create a username `bob`
with password, `training`.

Enable the userpass auth method.

```shell-session
vault auth enable userpass
```{{execute HOST01}}

Create a user, `bob`.

```shell-session
vault write auth/userpass/users/bob password="training" policies="test"
```{{execute HOST01}}
