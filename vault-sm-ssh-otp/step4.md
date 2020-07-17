```shell-session
vault login -method=userpass username=bob password=training
```{{execute HOST01}}

Generate an OTP credential for an IP of the remote host belongs to the
`otp_key_role`:

```shell-session
vault write ssh/creds/otp_key_role ip=HOST02
```{{execute HOST01}}

```shell-session
ssh -l ubuntu@HOST02
```{{execute HOST01}}