In the previous step you configured the PostgreSQL secrets engine with the
allowed role named `readonly`. A role is a logical name within Vault that maps
to database credentials. These credentials are expressed as SQL statements and
assigned to the Vault role.

Display the SQL used to create credentials stored in `readonly.sql`.

```shell
cat readonly.sql
```{{execute}}

The SQL contains the templatized fields `{{name}}`, `{{password}}`, and
`{{expiration}}`. These values are provided by Vault when the credentials are
created. This creates a new role and then grants that role the permissions
defined in the Postgres role named `ro`. This Postgres role was created when
Postgres was started.

Create the role named `readonly` that creates credentials with the
`readonly.sql`.

```shell
vault write database/roles/readonly \
    db_name=postgresql \
    creation_statements=@readonly.sql \
    default_ttl=1h \
    max_ttl=24h
```{{execute}}

The role generates database credentials with a default TTL of 1 hour and max TTL
of 24 hours.
