The application's database contains fields encrypted with the first version of the transit key.

Run the application again to re-wrap the encrypted fields.

```shell
VAULT_TOKEN=$APP_TOKEN \
  VAULT_ADDR=$VAULT_ADDR \
  VAULT_TRANSIT_KEY=my_app_key \
  SHOULD_SEED_USERS=true \
  dotnet run
```{{execute}}

The application finishes after it re-wraps the encrypted fields in the existing entries.

Connect to the database with the root credentials.

```shell
docker exec -it mysql-rewrap mysql -uroot -proot
```{{execute}}

Connect to the `my_app` table.

```shell
CONNECT my_app;
```{{execute}}


Display 10 rows from the `user_data` table where the city starts with a Vault
transit key version `v1`.

```shell
SELECT * FROM user_data WHERE city LIKE "vault:v1%" limit 10;
```{{execute}}

The results of this query are an empty set.

Display 10 rows from the `user_data` table where the city starts with a Vault
transit key version `v2`.

```shell
SELECT * FROM user_data WHERE city LIKE "vault:v2%" limit 10;
```{{execute}}

The results display 10 rows that match this query. The city field is encrypted with the second version of the Vault transit key.

Drop the connection to the database.

```shell
exit
```{{execute}}
