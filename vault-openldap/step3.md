After configuration immediately rotate the _root credentials_ to ensure Vault maintains the only valid credentials.

Rotate the root credential.

```shell
vault write -f openldap/rotate-root
```{{execute}}
