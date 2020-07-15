In **another terminal**, start a RabbitMQ server running on port `15672` that
has a user named `learn_vault` with the password `hashicorp`.

```shell
docker run --rm --name some-rabbit -p 15672:15672 \
    -e RABBITMQ_DEFAULT_USER=learn_vault \
    -e RABBITMQ_DEFAULT_PASS=hashicorp \
    rabbitmq:3-management
```{{execute T2}}

The RabbitMQ server downloads the necessary images and then starts a container.

In **another terminal**, start a Vault dev server with `root` as the root
token that listens for requests at `0.0.0.0:8200`.

```shell
vault server -dev -dev-root-token-id root -dev-listen-address 0.0.0.0:8200
```{{execute T3}}

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