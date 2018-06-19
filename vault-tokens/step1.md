Each token has a time-to-live (TTL) with an exception of the `root` token.  Tokens get **revoked** automatically by Vault when it reaches its TTL.

When the interaction between Vault and its client takes only a few seconds, there is no need to keep the token alive for longer than necessary. If you don't explicitly specify, token's default TTL is 32 days.  Let's create a token which is only valid for 30 seconds.


First, let's see the help message on token creation.

> Enter the following command into the terminal, or click on the command to automatically copy it into the terminal and execute it.

```
vault token create -h
```{{execute T2}}

## Create a Short-Lived Token

To specify the life of a token, run the `vault token create` command with `-ttl` parameter:

```
vault token create -ttl=<duration>
```

To clear the screen: `clear`{{execute T2}}

Execute the following command to create a token whose TTL is **30 seconds**, and save the generated token in a file named, `ttl_token.txt`.

```
vault token create -ttl=30s  \
    -format=json | jq -r ".auth.client_token" > ttl_token.txt
```{{execute T2}}

> Notice that the generated token inherits the parent token's policy.  For the training, you are logged in with `root` token.  When you create a new token, it inherits the parent token's policy unless you specify with **`-policy`** parameter (e.g. `vault token create -policy="base" -ttl=30s`).


## Test the Token

```
vault login $(cat ttl_token.txt)
```{{execute T2}}

The output displays the **`token_duration`** left with this token in seconds.


Wait for a few seconds to let the TTL to be reached, and re-run the login command:

```
vault login $(cat ttl_token.txt)
```{{execute T2}}

You should receive **permission denied** error. After 30 seconds, the token gets revoked automatically, and you can no longer make any request with this token.


Log back in with `root` token:

```
vault login root
```{{execute T2}}
