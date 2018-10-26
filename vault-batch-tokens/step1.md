Batch tokens are designed to be lightweight with limited flexibility. The
following table highlights the difference.

|                                                                                                                           |                                          Service Tokens |                                    Batch Tokens |
| ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------: | ----------------------------------------------: |
| Can be root tokens                                                                                                        |                                                     Yes |                                              No |
| Can create child tokens                                                                                                   |                                                     Yes |                                              No |
| Renewable                                                                                                                 |                                                     Yes |                                              No |
| Can be periodic                                                                                                           |                                                     Yes |                                              No |
| Can have explicit Max TTL                                                                                                 |                                                     Yes |                    No (always uses a fixed TTL) |
| Has accessors                                                                                                             |                                                     Yes |                                              No |
| Has Cubbyhole                                                                                                             |                                                     Yes |                                              No |
| Revoked with parent (if not orphan)                                                                                       |                                                     Yes |                                   Stops Working |
| Dynamic secrets lease assignment                                                                                          |                                                    Self |                          Parent (if not orphan) |
| Can be used across [Performance Replication](https://www.vaultproject.io/docs/enterprise/replication/index.html) clusters |                                                      No |                                             Yes |
| Creation scales with [performance standby node](/vault/operations/performance-standbys.html) count                        |                                                      No |                                             Yes |
| Cost                                                                                                                      | Heavyweight; multiple storage writes per token creation | Lightweight; no storage cost for token creation |


## Create a batch token

To create a batch token, you need to explicitly set the token type to be `batch`.

Execute the following command:

```
vault token create -type="batch"
```{{execute T2}}

Currently, you are logged in with `root` token; therefore, the child token inherits its creator's policy in absence of `-policy` flag.

```
URL: POST http://127.0.0.1:8200/v1/auth/token/create
Code: 400. Errors:

* batch tokens cannot be root tokens
```

Batch tokens **cannot** be root tokens.  `clear`{{execute T2}}


Let's create a policy named, `base`.

```
vault policy write base base.hcl
```{{execute T2}}

To review the created policy:

```
vault policy read base
```{{execute T2}}


Now, create a batch token with a non-root policy attached and save it to `token.txt` file:

```
vault token create -type=batch -policy=base -format=json \
      | jq -r ".auth.client_token" > token.txt
```{{execute T2}}

Notice that the generated token value is much longer than the service tokens
(`token.txt`{{open}}). This is because batch tokens are encrypted by the Vault's
barrier.

Let's view the generated batch token's properties:

```
vault token lookup $(cat token.txt)
```{{execute T2}}

The output look similar to the following:

```
Key                 Value
---                 -----
accessor            n/a
creation_time       1540592796
creation_ttl        768h
display_name        token
entity_id           n/a
expire_time         2018-11-27T14:26:36-08:00
explicit_max_ttl    0s
id                  b.AAAAAQKf5kVdMwjIwt4o49fDHIfEELolVEbz-rAzlKOlHTrGW_aZrFslOezTsk4JjuTwYtzNONARecYwJRjx59GQmiX6icA7gxnKKzsD3cPYtI10CHoH1GFAyGTN2K4gLIYeHBWdq6O2
issue_time          2018-10-26T15:26:36-07:00
meta                <nil>
num_uses            0
orphan              false
path                auth/token/create
policies            [base default]
renewable           false
ttl                 767h59m46s
type                batch
```

Notice that the **type** is **batch**, and it does not have a token accessor. Also, the **renewable** parameter is set to `false` since batch tokens are NOT renewable.
