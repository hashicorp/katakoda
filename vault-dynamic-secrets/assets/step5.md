The credentials are managed by the lease ID and remain valid for the lease
duration (TTL) or until revoked. Once revoked the credentials are no longer
valid.

Login with the `admin` user using the `userpass` authentication method.

```shell
vault login -method=userpass \
  username=admin \
  password=admin-password
```{{execute}}

List the existing leases.

```shell
vault list sys/leases/lookup/database/creds/readonly
```{{execute}}

All valid leases for database credentials are displayed.

Create a variable that stores the first lease ID.

```shell
LEASE_ID=$(vault list -format=json sys/leases/lookup/database/creds/readonly | jq -r ".[0]")
```{{execute}}

Renew the lease for the database credential by passing its lease ID.

```shell
vault lease renew database/creds/readonly/$LEASE_ID
```{{execute}}

The TTL of the renewed lease is set to `1h`.

Revoke the lease without waiting for its expiration.

```shell
vault lease revoke database/creds/readonly/$LEASE_ID
```{{execute}}

List the existing leases.

```shell
vault list sys/leases/lookup/database/creds/readonly
```{{execute}}

The lease is no longer valid and is not displayed.

Read new credentials from the `readonly` database role.

```shell
vault read database/creds/readonly
```{{execute}}

All leases associated with a path may be removed.

Revoke all the leases with the prefix `database/creds/readonly`.

```shell
vault lease revoke -prefix database/creds/readonly
```{{execute}}

The `prefix` flag matches all valid leases with the path prefix of
`database/creds/readonly`.

List the existing leases.

```shell
vault list sys/leases/lookup/database/creds/readonly
```{{execute}}

All the leases with this path as a prefix have been revoked.
