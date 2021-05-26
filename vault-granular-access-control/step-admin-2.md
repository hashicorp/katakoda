```
                    ____
                  .'* *.'
               __/_*_*(_
              / _______ \     _______
             _\_)/___\(_/_   < New
            / _((\- -/))_ \      keys. >
            \ \   (-)   / /      ------
             ' \___.___/ '
            / ' \__.__/ ' \
           / _ \ - | - /_  \
          (   ( .;''';. .'  )
          _\"__ /    )\ __"/_
            \/  \   ' /  \/
             .'  '...' ' )
              / /  |  \ \
             / .   .   . \
            /   .     .   \
           /   /   |   \   \
         .'   /    b    '.  '.
     _.-'    /     Bb     '-. '-._
 _.-'       |      BBb       '-.  '-.
(________mrf\____.dBBBb.________)____)
```

The administrator requires the ability to manage the database leases stored
within Vault. These secrets are maintained in a database secrets engine at the
path `database` in a role named `readonly`. The leases are stored at
`sys/leases/lookup/database/creds/+`

Login with the `root` user.

```shell
vault login root
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

## Enact the policy

What policy is required to meet this requirement?

1. Define the policy in the local file.
2. Update the policy named `admins-policy`.
3. Test the policy with the `admins` user.

<br />

#### 1️⃣ with the CLI flags

Run the command with the `-output-curl-string` flag.

#### 2️⃣ with the audit logs

The last command executed is recorded as the last object:

`cat log/vault_audit.log | jq -s ".[-1].request.path,.[-1].request.operation"`.

### 3️⃣ with the API docs

Select the Database API tab to read the [Database API
documentation](https://www.vaultproject.io/api-docs/secret/databases).

Read the [Leases API
documentation](https://www.vaultproject.io/api-docs/system/leases)
