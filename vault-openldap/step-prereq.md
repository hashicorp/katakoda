For the purpose of this tutorial, let's run a community based OpenLDAP Docker image in a container.

Run a OpenLDAP server in a Docker container.

```shell
docker run \
  --name vault-openldap \
  --env LDAP_ORGANISATION="learn" \
  --env LDAP_DOMAIN="learn.example" \
  --env LDAP_ADMIN_PASSWORD="2LearnVault" \
  -p 389:389 \
  -p 636:636 \
  --detach \
  --rm \
  osixia/openldap:latest
```{{execute}}

Verify that the OpenLDAP container is running.

```shell
docker ps -f name=vault-openldap --format "table {{.Names}}\t{{.Status}}"
```{{execute}}

View the OpenLDAP data in `openldap-data.ldif`.

```shell
cat learn-vault-example.ldif
```{{execute}}

Add the data in `openldap-data.ldif` to the OpenLDAP server.

```shell
ldapadd -cxD "cn=admin,dc=learn,dc=example" \
  -w 2LearnVault \
  -f learn-vault-example.ldif
```{{execute}}

The output displays the new entries added to the OpenLDAP server.

Now you are ready to configure Vault.