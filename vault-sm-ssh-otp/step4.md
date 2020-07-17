```shell-session
vault login -method=userpass username=bob password=training
```{{execute HOST1}}

Generate an OTP credential for an IP of the remote host belongs to the
`otp_key_role`:

```shell-session
vault write ssh/creds/otp_key_role ip=[[HOST2_IP]]
```{{execute HOST1}}

```shell-session
ssh -l root@[[HOST2_IP]]
```{{execute HOST1}}