You can **renew** the service token's TTL as long as it has not expired.

Create a token and save its value in a file named, `test_token.txt`.

```
vault token create -ttl=45 -explicit-max-ttl=120 -policy=default -format=json \
    | jq -r ".auth.client_token" > test_token.txt
```{{execute T1}}

The generated token has a TTL of 45 seconds, and max TTL of 2 minutes (120 seconds).

Renew the token's TTL before the token expires.

```
vault token renew $(cat test_token.txt)
```{{execute T1}}

Renew and extend the token's TTL to 60 seconds.

```
vault token renew -increment=60 $(cat test_token.txt)
```{{execute T1}}

Notice that the token TTL (`token_duration`) is now 1 minute instead of 45 seconds.

Because the explicit max TTL is set to 2 minutes, you will not be able to renew the token **after 2 minutes**.

As time passes, Vault returns a message such as `TTL of "26s" exceeded the effective max_ttl of "10s"; TTL value is capped accordingly` to indicate that the token TTL cannot exceed 2 minutes from its creation time.

```
vault token renew -increment=60 $(cat test_token.txt)
```{{execute T1}}

Eventually, the token expires and Vault automatically revokes it. Once the token expires, the renew command returns `token not found` message.

```
vault token renew -increment=60 $(cat test_token.txt)
```{{execute T1}}


## Revoke service tokens

If a user or machine needs a temporal access to Vault, you can set a short TTL or a number of uses to a service token so the token is automatically revoked at the end of its life. But if any suspicious activity was detected, Vault has
built-in support for revocation of service tokens before reaching its TTL.

Create a token and save its value in a file, `revoke_token.txt`.

```
vault token create -ttl=2h -policy=default -format=json \
    | jq -r ".auth.client_token" > revoke_token.txt
```{{execute T1}}

The generated token has a TTL of 2 hours.

Revoke the generated service token.

```
vault token revoke $(cat revoke_token.txt)
```{{execute T1}}

Verify that the token no longer exists by tring to look it up.

```
vault token lookup $(cat revoke_token.txt)
```{{execute T1}}

Vault returns an error message.

```
Error looking up token: Error making API request.

URL: POST http://127.0.0.1:8200/v1/auth/token/lookup
Code: 403. Errors:

* bad token
```

Instead of revoking using a token value, you can revoke tokens with a [token accessor](https://www.vaultproject.io/docs/concepts/tokens/#token-accessors) using the `-accessor` flag.
