Enable the RabbitMQ secrets engine at the `rabbitmq-no-policy` path.

```shell
vault secrets enable -path rabbitmq-no-policy rabbitmq
```{{execute}}

Configure the secrets engine to connect to the RabbitMQ server.

```shell
vault write rabbitmq-no-policy/config/connection \
    connection_uri=http://localhost:15672 \
    username="learn_vault" \
    password="hashicorp"
```{{execute}}

Create a role named `example`.

```shell
vault write rabbitmq-no-policy/roles/example vhosts='{"/":{"write": ".*", "read": ".*"}}'
```{{execute}}

Generate a login from the `example` role.

```shell
vault read rabbitmq-no-policy/creds/example
```{{execute}}

The password displayed does not have any special characters and exceeds the
requirement that the password length be 20 characters.
