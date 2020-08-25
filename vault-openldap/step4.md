Create a Vault role named `learn` mapped to the OpenLDAP username `alice`.

```shell
vault write openldap/static-role/learn \
  dn='cn=alice,ou=users,dc=learn,dc=example' \
  username='alice' \
  rotation_period="24h"
```{{execute}}

The `learn` role is ready to generate credentials.
