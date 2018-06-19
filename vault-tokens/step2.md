First, create a policy named, `base` by executing the following command:

```
vault policy write base base.hcl
```{{execute T2}}

To review the created policy:

```
vault policy read base
```{{execute T2}}

Let's create another token with base policy and TTL of 60 seconds, and save the generated token in a file named, `token_60s.txt`.

```
vault token create -ttl 60s -policy=base  \
     -format=json | jq -r ".auth.client_token" > token_60s.txt
```{{execute T2}}


Execute the following command to take a look at the token details:

```
vault token lookup $(cat token_60s.txt)
```{{execute T2}}

The output displays the **`ttl`** left with this token in seconds.

<br>

## Renew the Token

Although a token has a short TTL, it can be renewed for as long as it hasn't reached its TTL via `renew` operation.

Execute the following command to renew the token and double its TTL:

```
vault token renew -increment=120s $(cat token_60s.txt)
```{{execute T2}}


Look up the token details again to verify that is TTL has been updated.

```
vault token lookup $(cat token_60s.txt)
```{{execute T2}}

The **`ttl`** should reflect the changes.

To clear the screen: `clear`{{execute T2}}
