The applications that require the database credentials read them from the secret
engine's _readonly_ role.

View the policies required to perform the **apps** responsibilities in this
scenario.

```shell
cat apps-policy.hcl
```{{execute}}

Login with the `apps` user using the `userpass` authentication method.

```shell
vault login -method=userpass \
  username=apps \
  password=apps-password
```{{execute}}

Read credentials from the `readonly` database role.

```shell
vault read database/creds/readonly
```{{execute}}

The Postgres credentials are displayed as `username` and `password`. The
credentials are identified within Vault by the `lease_id`.

### Validation

Connect to the Postgres database via the CLI within the `postgres` container.

```shell
docker exec -it postgres psql
```{{execute}}

Your system prompt is replaced with a new prompt `root=#`. Commands issued at
this prompt are executed against the Postgres database running within the
container.

List all the database users.

```shell
SELECT usename, valuntil FROM pg_user;
```{{execute}}

The output displays a table of all the database credentials generated. The
credentials that were recently generated appear in this list.

Disconnect from the Postgres database.

```shell
\q
```{{execute}}
