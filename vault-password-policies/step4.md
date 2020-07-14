Enable the RabbitMQ secrets engine at the `rabbitmq-with-policy` path.

```shell
vault secrets enable -path rabbitmq-with-policy rabbitmq
```{{execute}}

Configure the secrets engine to connect to the RabbitMQ server.

```shell
vault write rabbitmq-with-policy/config/connection \
    connection_uri=http://localhost:15672 \
    username="learn_vault" \
    password="hashicorp" \
    password_policy="example"
```{{execute}}

Create a role named `example`.

```shell
vault write rabbitmq-with-policy/roles/example vhosts='{"/":{"write": ".*", "read": ".*"}}'
```{{execute}}

Generate a login from the `example` role.

```shell
vault read rabbitmq-with-policy/creds/example
```{{execute}}

The password displayed meets the requirements defined by the password policy.