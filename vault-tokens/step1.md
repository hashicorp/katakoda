Login with root token.

```
vault login root
```{{execute T1}}

Each token has a time-to-live (TTL) with an exception of the `root` token.  Tokens get **revoked** automatically by Vault when it reaches its TTL.

When the interaction between Vault and its client takes only a few seconds, there is no need to keep the token alive for longer than necessary. If you don't explicitly specify, token's default TTL is 32 days.  Let's create a token which is only valid for 30 seconds.


## Create a token with use limit

To limit the number of times that a token can be used, pass the `-use-limit` parameter with desired count.

```
vault token create -use-limit=<integer>
```

To view optional parameters to create tokens, run the command with `-help` flag.

```
vault token create -help
```{{execute T1}}

There are a number of parameters you can set.

```
clear
```{{execute T1}}

Create a token with TTL of 1 hour and a use limit of 2. Attach the `default` policy and save the generated token in a file named, `use-limit-token.txt`.

```
vault token create -ttl=1h -use-limit=2 -policy=default \
   -format=json | jq -r ".auth.client_token" > use-limit-token.txt
```{{execute T1}}


### Verification

Execute some commands using the token.

```
VAULT_TOKEN=$(cat use-limit-token.txt) vault token lookup
```{{execute T1}}

Notice that the `num_uses` is now `1`.

Run another CLI command using the token.

```
VAULT_TOKEN=$(cat use-limit-token.txt) vault write cubbyhole/token value=1234567890
```{{execute T1}}

Try to read the value now using the same token.

```
VAULT_TOKEN=$(cat use-limit-token.txt) vault read cubbyhole/token
```{{execute T1}}

The first command read the token's properties and then wrote a value to the cubbyhole secrets engine. This exhausted the use limit of 2 for this token. Therefore, the attempt to read the secret from the cubbyhole failed.
