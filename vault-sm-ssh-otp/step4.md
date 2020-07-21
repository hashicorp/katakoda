Authenticate via `userpass` method with the username `bob` and password `training`.

```shell-session
vault login -method=userpass username=bob password=training
```{{execute HOST1}}

Create a new OTP and SSH into the remote host using [`sshpass`](https://gist.github.com/arunoda/7790979).

```shell-session
vault ssh -role otp_key_role -mode otp -strict-host-key-checking=no ubuntu@[[HOST2_IP]]
```{{execute HOST1}}