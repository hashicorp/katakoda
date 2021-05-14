# Generate a key

The Nomad command-line tool includes the `nomad operator keygen` command for
generating a new secure gossip encryption key.

```shell
nomad operator keygen
```{{execute interrupt}}

```screenshot
nomad operator keygen
J30JTrPTqAKZfYLJcvQfu/iLM4VgTFSIGNmeaeulwjI=
```

You can use any method that can create 32 random bytes encoded in base64.

`openssl rand -base64 32`{{execute}}

`dd if=/dev/urandom bs=32 count=1 2>\dev\null | base64`{{execute}}

This guide will use the token `J30JTrPTqAKZfYLJcvQfu/iLM4VgTFSIGNmeaeulwjI=` for
the rest of the lab.
