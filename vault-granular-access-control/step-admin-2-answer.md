## Enact the policy

The admin requires the ability to `read` credentials from the
`database/creds/readonly` path. To manage the lease of credentials requires
`sys/leases/+/database/creds/readonly/+` path with several capabilities. Lastly,
to revoke all the leases requires `sys/leases/+/database/creds/readonly` path
with several capabilities.

```hcl
path "database/creds/readonly" {
  capabilities = [ "read" ]
}

path "sys/leases/+/database/creds/readonly/+" {
  capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
}

path "sys/leases/+/database/creds/readonly" {
  capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
}
```

Open the `admins-policy.hcl`{{open}} and append the following policies.

<pre class="file" data-filename="admins-policy.hcl" data-target="append">
path "database/creds/readonly" {
  capabilities = [ "read" ]
}

path "sys/leases/+/database/creds/readonly/+" {
  capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
}

path "sys/leases/+/database/creds/readonly" {
  capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
}
</pre>

Update the policy named `admins-policy`.

```shell
vault policy write admins-policy admins-policy.hcl
```{{execute}}

#### Test the policy

Login with the `admins` user.

```shell
clear
vault login -method=userpass \
  username=admins \
  password=admins-password
```{{execute}}

Get the database credentials from the database role.

```shell
vault read database/creds/readonly
```{{execute}}

List the existing leases.

```shell
vault list sys/leases/lookup/database/creds/readonly
```{{execute}}

Create a variable that stores the first lease ID.

```shell
LEASE_ID=$(vault list -format=json sys/leases/lookup/database/creds/readonly | jq -r ".[0]")
```{{execute}}

Renew the lease for the database credential by passing its lease ID.

```shell
vault lease renew database/creds/readonly/$LEASE_ID
```{{execute}}

Revoke the lease without waiting for its expiration.

```shell
vault lease revoke database/creds/readonly/$LEASE_ID
```{{execute}}

Revoke all the leases with the prefix `database/creds/readonly`.

```shell
vault lease revoke -prefix database/creds/readonly
```{{execute}}

Wait until the `admins` user is able to perform every operation successfully.
