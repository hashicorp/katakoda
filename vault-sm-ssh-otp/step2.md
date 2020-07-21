The client must have permissions against the `ssh/creds/otp_key_role` path to
request an OTP for `otp_key_role`. First, create a policy file named,
`test.hcl`.

```shell-session
tee test.hcl <<EOF
path "ssh/creds/otp_key_role" {
  capabilities = ["create", "read", "update"]
}
EOF
```{{execute HOST1}}

Create a policy named `test` with the policy defined in `test.hcl`.

```shell-session
vault policy write test ./test.hcl
```{{execute HOST1}}

Enable the `userpass` auth method.

```shell-session
vault auth enable userpass
```{{execute HOST1}}

Create a user named `bob` with the password "training" assigned the `test` policy.

```shell-session
vault write auth/userpass/users/bob password="training" policies="test"
```{{execute HOST1}}
