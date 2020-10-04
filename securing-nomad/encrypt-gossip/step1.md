The Nomad CLI includes an `operator keygen` command for generating a new secure
gossip encryption key.

```shell
nomad operator keygen
```{{execute interrupt}}

```screenshot
nomad operator keygen
cg8StVXbQJ0gPvMd9o7yrg==
```

Current and older versions of `nomad operator keygen` return 16 bytes; however,
Nomad supports gossip encryption keys of 32 bytes as well. Supplying a 32 byte
key enables AES-256 mode, where supplying a 16 byte key enables AES-128 mode.

You can use any method that can create 32 random bytes encoded in base64.

```shell
openssl rand -base64 32
```{{execute}}

```shell
dd if=/dev/urandom bs=32 count=1 status=none | base64
```{{execute}}

This guide will use the token `BSq3lEdNa+DFQBam11mhJTue3UmO2F//Cqs5oCnp/3w=` for the remainder of
the commands.
