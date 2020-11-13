Unlike format preserving encryption (FPE) transformation, tokenization is a stateful procedure to facilitate mapping between tokens and various cryptographic values (one way HMAC of the token, encrypted metadata, etc.) including the encrypted plaintext itself which must be persisted.

At scale, this could put a lot of additional load on the Vault's storage backend. To avoid this, you have an option to use external storage to persist data for tokenization transformation.

<div style="background-color:#fcf6ea; color:#864242; border:1px solid #f8cfcf; padding:1em; border-radius:3px; margin:24px 0;">
<p>
**NOTE:** Currently, supported database for external storage is PostgreSQL.
</p></div>

To demonstrate, run a PostgreSQL database in a Docker container. Create a new transformation named, "passport" which uses this PostgrsSQL as its storage rather than using the Vault's storage backend.

![Scenario](./assets/vault-tokenization-3.png)

Run [PostgreSQL Docker image](https://hub.docker.com/_/postgres) in a container.

Start a `postgres` instance which listens to port `5432`, and the superuser (`root`) password is set to `rootpassword`.

```
docker run --name postgres -e POSTGRES_USER=root \
   -e POSTGRES_PASSWORD=rootpassword \
   -d -p 5432:5432 postgres
```{{execute T1}}

Log in with `root` token.

```
vault login root
```{{execute T1}}

Create a new role, "global-id".

```
vault write transform/role/global-id transformations=passport
```{{execute T1}}

Create a store which points to the postgres.

```
vault write transform/stores/postgres type=sql supported_transformations=tokenization \
    connection_string='postgresql://{{username}}:{{password}}@localhost/root?sslmode=disable' \
    username=root password=rootpassword
```{{execute T1}}

Create a schema in postgres to store tokenization artifacts.

```
vault write transform/stores/postgres/schema transformation_type=tokenization \
    username=root password=rootpassword
```{{execute T1}}

Create a new transformation named, "passport" which points to the postgres store.

```
vault write transform/transformations/tokenization/passport \
    allowed_roles=global-id stores=postgres
```{{execute T1}}

Click the **+** next to the opened Terminal, and select **Open New Terminal** to start third terminal (**Terminal 2**).

![](./assets/ops-another-terminal.png)

Connect to the `postgres` container.

```
docker exec -it postgres bash
```{{execute T2}}

Start `psql`.

```
psql -U root
```{{execute T2}}

Check to verify that there is no entry.

```
select * from tokens;
```{{execute T2}}

The output should display an empty table.

```
storage_token | key_version | ciphertext | encrypted_metadata | fingerprint | expiration_time
---------------+-------------+------------+--------------------+-------------+-----------------
(0 rows)
```

Return to the terminal you were running Vault CLI, and encode some test data.

```
vault write transform/encode/global-id transformation=passport \
   value="123456789"
```{{execute T1}}

Return to the postgres container, and check the data entry.

```
select * from tokens;
```{{execute T2}}

As you encode more data, the table entry grows.
