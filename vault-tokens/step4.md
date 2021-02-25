Before creating an orphan token, let's explore the service token's lifecycle.

Create a token, and save the generated token in a file named, `parent_token.txt`.

```
vault token create -ttl=120s \
      -format=json | jq -r ".auth.client_token" > parent_token.txt
```{{execute T1}}

Now, create a child token with the generated token and save it in a file named, `child_token.txt`:

```
VAULT_TOKEN=$(cat parent_token.txt) vault token create -ttl=80s \
      -format=json | jq -r ".auth.client_token" > child_token.txt
```{{execute T1}}

Try running some commands using this child token.

```
vault token lookup $(cat child_token.txt)
```{{execute T1}}

Revoke the parent token.

```
vault token revoke $(cat parent_token.txt)
```{{execute T1}}

Now, let's see what happened to the child token. Execute the following command to lookup the child token.

```
vault token lookup $(cat child_token.txt)
```{{execute T1}}

The output should look like:

```
Error looking up token: Error making API request.

URL: POST http://127.0.0.1:8200/v1/auth/token/lookup
Code: 403. Errors:

* bad token
```

This is because the child token was revoked when its parent got revoked. When the default behavior is undesirable, you can create an **orphan token** instead.

Repeat the steps to create a token and login with the generated token.

```
vault token create -ttl=60s \
      -format=json | jq -r ".auth.client_token" > parent_token.txt
```{{execute T1}}


## Create an Orphan Token

Orphan tokens are **not** children of their parent; therefore, orphan tokens do not expire when their parent does.

> **NOTE:** Orphan tokens still expire when their own max TTL is reached.

Create a new parent token.

```
vault token create -ttl=90s \
      -format=json | jq -r ".auth.client_token" > parent_token.txt
```{{execute T1}}

Create an orphan token and save it to a file named, `orphan_token.txt`.

```
VAULT_TOKEN=$(cat parent_token.txt) vault token create -ttl=180s -orphan \
      -format=json | jq -r ".auth.client_token" > orphan_token.txt
```{{execute T1}}

This child token will continue to be active for 180 seconds even after its parent token gets revoked.


## Test the Orphan Token

Revoke the parent token.

```
vault token revoke $(cat parent_token.txt)
```{{execute T1}}

Verify that the child token still exists:

```
vault token lookup $(cat orphan_token.txt)
```{{execute T1}}

Notice that the **orphan** is set to **true**.
