Enable the RabbitMQ secrets engine at the `rabbitmq-default-policy` path.

```shell
vault secrets enable -path rabbitmq-default-policy rabbitmq
```{{execute}}

Configure the secrets engine to connect to the RabbitMQ server.

```shell
vault write rabbitmq-default-policy/config/connection \
    connection_uri=http://localhost:15672 \
    username="learn_vault" \
    password="hashicorp"
```{{execute}}

Create a role named `example`.

```shell
vault write rabbitmq-default-policy/roles/example vhosts='{"/":{"write": ".*", "read": ".*"}}'
```{{execute}}

Generate a login from the `example` role.

```shell
vault read rabbitmq-default-policy/creds/example
```{{execute}}

The password displayed does not have any special characters and exceeds the
requirement that the password length be 20 characters.
