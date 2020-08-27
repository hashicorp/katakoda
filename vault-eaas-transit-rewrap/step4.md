The encryption key (`my_app_key`) can be rotated.

Rotate the `my_app_key` transit key.

```shell
vault write -f transit/keys/my_app_key/rotate
```{{execute}}

Display information about the `my_app_key` transit key.

```shell
vault read transit/keys/my_app_key
```{{execute}}

The output displays that this transit key has two versions.
