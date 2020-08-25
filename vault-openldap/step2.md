Configure the OpenLDAP secrets engine in Vault.

The following command configures the OpenLDAP secrets engine using the `openldap` plugin to communicate with our Docker based OpenLDAP container.

```shell
vault write openldap/config \
  binddn=cn=admin,dc=learn,dc=example \
  bindpass=2LearnVault \
  url=ldap://127.0.0.1
```{{execute}}
