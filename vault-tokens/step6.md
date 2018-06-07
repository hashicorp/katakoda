When the default behavior is undesirable, you can create an **orphan token** instead.

Repeat the steps to create a token and login with the generated token.

```
vault token create -ttl=80s \
      -format=json | jq -r ".auth.client_token" > parent_token.txt
```{{execute}}

```
vault login $(cat parent_token.txt)
```{{execute}}

## Create an Orphan Token

To create an orphan token, you can simply pass the **`-orphan`** flag when you create a token.

Execute the following command to generate an orphan token and save it to a file named, `orphan_token.txt`.

```
vault token create -ttl=120s -orphan \
      -format=json | jq -r ".auth.client_token" > orphan_token.txt
```{{execute}}

This child token will continue to be active for 120 seconds even after its parent token gets revoked.


## Test the Orphan Token

Log back in with `root` token:

```
vault login $(cat root_token.txt)
```{{execute}}

Execute the following command to revoke the parent token:

```
vault token revoke $(cat parent_token.txt)
```{{execute}}

Verify that the child token still exists:

```
vault token lookup $(cat orphan_token.txt)
```{{execute}}

Notice that the **orphan** is set to **true**.
