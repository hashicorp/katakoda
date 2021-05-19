## Enact the policy

The admin requires the `create`, `read`, `update`, `delete`, `list`, `sudo`
capability for the path `sys/leases/+/database/creds/readonly`.

```hcl
path "sys/leases/+/database/creds/readonly" {
  capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
}
```

Open the `admins-policy.hcl`{{open}} and append the following policies.

<pre class="file" data-filename="admins-policy.hcl" data-target="append">
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
vault login -method=userpass \
  username=admins \
  password=admins-password
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
