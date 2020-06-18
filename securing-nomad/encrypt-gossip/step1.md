The Nomad CLI includes a operator keygen command for generating a new secure gossip encryption key.

```shell
nomad operator keygen
```{{execute interrupt}}

```screenshot
nomad operator keygen
cg8StVXbQJ0gPvMd9o7yrg==
```

Alternatively, you can use any method that can create 16 random bytes encoded in base64.

```shell
openssl rand -base64 16
```{{execute}}

```shell
dd if=/dev/urandom bs=16 count=1 status=none | base64
```{{execute}}

This guide will use the token `cg8StVXbQJ0gPvMd9o7yrg==` for the remainder of
the commands.
