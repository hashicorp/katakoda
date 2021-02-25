Create a new service token with TTL of 40 seconds which means that the token gets automatically revoked after 40 seconds.

Create a token with TTL of 40 seconds and save it in a file named, `short-lived-token.txt`.

```
vault token create -ttl=40s  -format=json \
   | jq -r ".auth.client_token" > short-lived-token.txt
```{{execute T1}}

Lookup the token details.

```
vault token lookup $(cat short-lived-token.txt)
```{{execute T1}}

> **NOTE:** The `vault token lookup` command returns the token's properties. 

When you execute a Vault command using the new token immediately following its creation, it should work. Wait for 40 seconds and try again. It returns **`Code: 403. Errors:`** which indicates a forbidden API call due to expired
token usage.

```
vault token lookup $(cat short-lived-token.txt)
```{{execute T1}}

```
clear
```{{execute T1}}
