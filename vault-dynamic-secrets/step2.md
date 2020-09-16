The database secrets engine supports many databases through a plugin interface.
To use a Postgres database with the secrets engine requires further
configuration with the `postgresql-database-plugin` plugin and connection
information.

Configure the database secrets engine with the connection credentials for the
Postgres database.

```shell
vault write database/config/postgresql \
    plugin_name=postgresql-database-plugin \
    connection_url="postgresql://{{username}}:{{password}}@localhost:5432/postgres?sslmode=disable" \
    allowed_roles=readonly \
    username="root" \
    password="rootpassword"
```{{execute}}

The secrets engine is configured to work with Postgres.