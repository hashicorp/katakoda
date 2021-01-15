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
vault list sys/leases/lookup/azure/creds/edu-app
```{{execute}}

All valid leases for Azure credentials are displayed.

Create a variable that stores the first lease ID.

```shell
LEASE_ID=$(vault list -format=json sys/leases/lookup/azure/creds/edu-app | jq -r ".[0]")
```{{execute}}

Renew the lease for the Azure credential by passing its lease ID.

```shell
vault lease renew azure/creds/edu-app/$LEASE_ID
```{{execute}}

The TTL of the renewed lease is set to `1h`.

Revoke the lease without waiting for its expiration.

```shell
vault lease revoke azure/creds/edu-app/$LEASE_ID
```{{execute}}

List the existing leases.

```shell
vault list sys/leases/lookup/azure/creds/edu-app
```{{execute}}

The lease is no longer valid and is not displayed.

Read new credentials from the `edu-app` role.

```shell
vault read azure/creds/edu-app
```{{execute}}

All leases associated with a path may be removed.

Revoke all the leases with the prefix `azure/creds/edu-app`.

```shell
vault lease revoke -prefix azure/creds/edu-app
```{{execute}}

The `prefix` flag matches all valid leases with the path prefix of
`azure/creds/edu-app`.

List the existing leases.

```shell
vault list sys/leases/lookup/azure/creds/edu-app
```{{execute}}

All the leases with this path as a prefix have been revoked.
