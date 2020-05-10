The TTL for `readonly` role is set to 1 hour.

```
vault read database/roles/readonly
```{{execute T1}}

Generate a new set of credentials and store the output in a file named, "new-lease.json"

```
VAULT_TOKEN=$(cat app-token.txt) vault read -format=json database/creds/readonly > new-lease.json
```{{execute T1}}

View the contents of the new-lease.json file.

```
cat new-lease.json
```{{execute T1}}

## Renew a lease

If you need to extend the lease TTL, execute the following command to renew the lease for this credential by passing its `lease_id`.

```
vault lease renew $(cat new-lease.json | jq -r ".lease_id")
```{{execute T1}}

## Revoke a lease

If the database credentials are not in use, you can revoke the lease before reaching its TTL.

Execute the following command to revoke the generated credentials.

```
vault lease revoke $(cat new-lease.json | jq -r ".lease_id")
```{{execute T1}}

To revoke all leases for the `readonly` role, execute the command with `-prefix=true` flag.

```
vault lease revoke -prefix database/creds/readonly
```{{execute T1}}

Once all the leases for the `readonly` role were revoked, the following command should return with "**No value found**" message.

```
vault list sys/leases/lookup/database/creds/readonly
```{{execute T1}}
