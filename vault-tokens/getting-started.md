This tutorial uses [Vault docker container](https://hub.docker.com/_/vault/) which is running Vault in development mode.

## Login to Vault

When Vault is running in development mode, it runs entirely in-memory and starts unsealed with a single unseal key. The root token is already authenticated to the CLI, so you can immediately begin using Vault.

First, get the generated root token by executing the following command:

```
docker logs vault > system.out
grep 'Root Token:' system.out | awk '{print $NF}' > root_token.txt
```{{execute}}

Login with root token:

```
vault login $(cat root_token.txt)
```{{execute}}

<br>
Now, you are logged in as a `root` and ready to play!
