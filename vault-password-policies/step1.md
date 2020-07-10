In **another terminal**, start a Vault dev server with `root` as the root
token that listens for requests at `0.0.0.0:8200`.

```shell
vault server -dev -dev-root-token-id root -dev-listen-address 0.0.0.0:8200
```{{execute T2}}

Setting the `-dev-listen-address` to `0.0.0.0:8200` overrides the default
address of a Vault dev server (`127.0.0.1:8200`) and enables Vault to be
addressable by the Kubernetes cluster and its pods because it binds to a
shared network.

Export an environment variable for the `vault` CLI to address the Vault server.

```shell
export VAULT_ADDR=http://0.0.0.0:8200
```{{execute T1}}

Request the status of the Vault server.

```shell
vault status
```{{execute T1}}

The Vault server reports that is initialized and unsealed.