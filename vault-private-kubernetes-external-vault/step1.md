Vault running external of a Kubernetes cluster can be addressed by any of its
pods as long as the Vault server is network addressable. Running Vault locally
alongside of Minikube is possible if the Vault server is bound to the same
network as the cluster.

Verify the `vault` CLI is installed.

```shell
vault version
```{{execute}}

Wait until the `vault version` command returns a value.

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

The web application that you deploy, expects Vault to store a username and
password stored at the path `secret/devwebapp/config`. To create this secret
requires that a [key-value secret
engine](https://www.vaultproject.io/docs/secrets/kv/kv-v2.html) is enabled and a
username and password is put at the specified path. By default the Vault dev
server starts with a key-value secrets engine enabled at the path prefixed with
`secret`.

Create a secret at path `secret/devwebapp/config` with a `username` and
`password`.

```shell
vault kv put secret/devwebapp/config username='giraffe' password='salsa'
```{{execute T1}}

Verify that the secret is defined at the path `secret/data/devwebapp/config`.

```shell
vault read -format json secret/data/devwebapp/config | jq ".data.data"
```{{execute T1}}

The Vault server, with secret, is ready to be addressed by a Kubernetes cluster
and the pods deployed in it.