Login with root token.

> Click on the command (`⮐`) will automatically copy it into the terminal and execute it.

```
vault login root
```{{execute T1}}

## Run a PostgreSQL Docker image

For the purpose of this tutorial, let's run [PostgreSQL Docker image](https://hub.docker.com/_/postgres) in a container.

Execute the following command to start a `postgres` instance which listens to port `5432`, and the superuser (`root`) password is set to `rootpassword`.

```
docker run --name postgres -e POSTGRES_USER=root \
         -e POSTGRES_PASSWORD=rootpassword \
         -d -p 5432:5432 postgres
```{{execute T1}}

Verify that the postgres container is running.

```
docker ps
```{{execute T1}}

```
CONTAINER ID        IMAGE            ...         PORTS                    NAMES
befcf913da91        postgres         ...         0.0.0.0:5432->5432/tcp   postgres
```

## Setup database secrets engine

Execute the following command to enable the database secrets engine at `database/` path.

```
vault secrets enable database
```{{execute T1}}

The PostgreSQL secrets engine needs to be configured with valid credentials. It is very common to give Vault the superuser credentials and let Vault manage the auditing and lifecycle credentials; it's much better than having one person manage the credentials.

```
vault write database/config/postgresql \
        plugin_name=postgresql-database-plugin \
        allowed_roles=readonly \
        connection_url=postgresql://root:rootpassword@localhost:5432/postgres?sslmode=disable
```{{execute T1}}

The next step is to define the `readonly` role. A role is a logical name that maps to a policy used to generate credentials. Since Vault does not know what kind of PostgreSQL users you want to create,
supply the information in SQL to create desired users.

View the provided `readonly.sql` file:

```
cat readonly.sql
```{{execute T1}}

The values within the `{{<value>}}` will be filled in by Vault. Notice that `VALID_UNTIL` clause. This tells PostgreSQL to revoke the credentials even if Vault is offline or unable to communicate with it.

```
CREATE ROLE "{{name}}" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO "{{name}}";
```

Execute the following command to creates a role named `readonly` with default TTL of 1 hour, and max TTL of the credential is set to 24 hours. The `readonly.sql` statement is passed as the role creation statement.

```
vault write database/roles/readonly db_name=postgresql \
   creation_statements=@readonly.sql \
   default_ttl=1h max_ttl=24h
```{{execute T1}}
