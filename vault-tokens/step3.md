Create a new service token with TTL of 60 seconds which means that the token gets automatically revoked after 60 seconds.

Create a token with TTL of 60 seconds and save it in a file named, `short-lived-token.txt`.

```
vault token create -ttl=60s \
   | jq -r ".auth.client_token" > short-lived-token.txt
```{{execute T1}}

Lookup the token details.

```
vault token lookup $(cat short-lived-token.txt)
```{{execute T1}}

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px;">
<p><strong>NOTE: </strong>
**NOTE:** The `vault token lookup` command returns the token's properties. In this example, it shows that this token has 38 more seconds before it expires.
</p></div>

When you execute a Vault command using the new token immediately following its creation, it should work. Wait for 60 seconds and try again. It returns **`Code: 403. Errors:`** which indicates a forbidden API call due to expired
token usage.

```
vault token lookup $(cat short-lived-token.txt)
```{{execute T1}}

```
clear
```{{execute T1}}
