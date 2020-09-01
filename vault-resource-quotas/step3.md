Lease count quota is designed to protect Vault from a large volume of leases and tokens persisted in Vault for a longer period of time than necessary and pressuring its storage backend. Large scale **Vault Enterprise** deployments have this governance challenge and organizational complexity ensuring there are guard rails for users in Vault as a service environment to not jeopardize system stability.

> **NOTE:** Lease Count Quotas is a part of **Vault Enterprise Platform** features.

Assuming that you have a database secrets engine enabled at "postgres" in the `us-west` namespace.

```
vault secrets enable -ns=us-west -path=postgres database
```{{execute T1}}

Create a lease count quota named, "db-creds" which limits the incoming requests for a new set of DB credentials to 100 requests per second maximum.

```
vault write sys/quotas/lease-count/db-creds max_leases=100 \
    path="us-west/postgres"
```{{execute T1}}
