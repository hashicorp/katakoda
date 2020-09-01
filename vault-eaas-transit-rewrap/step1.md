Enable the `transit` secrets engine.

```shell
vault secrets enable transit
```{{execute}}

Create an encryption key to use for transit named `my_app_key`.

```shell
vault write -f transit/keys/my_app_key
```{{execute}}

The transit key `my_app_key` is created.