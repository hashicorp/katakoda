Suppose a hierarchy exists with respective TTL as follows:

```
    b519c6aa... (3h)
        6a2cf3e7... (4h)
        1d3fd4b2... (1h)
            794b6f2f... (2h)
```

In this scenario, the token ID of `1d3fd4b2..` will expire in an hour. When the token is revoked, it takes its child (`794b6f2f...`) although the child has one more hour before it expires. Then, two hours later, `b519c6aa...` will be revoked and takes its child (`6a2cf3e7...`) with it.

This ensures that a user cannot escape revocation by simply generating a never-ending tree of child tokens.

## Explore the Token Lifecycle

First, create a token, and save the generated token in a file named, `parent_token.txt`.

```
vault token create -ttl=60s \
      -format=json | jq -r ".auth.client_token" > parent_token.txt
```{{execute T2}}


Login with the generated token:

```
vault login $(cat parent_token.txt)
```{{execute T2}}

Now, create a child token and save it in a file named, `child_token.txt`:

```
vault token create -ttl=80s \
      -format=json | jq -r ".auth.client_token" > child_token.txt
```{{execute T2}}

Try running some commands using this child token.

```
vault token lookup $(cat child_token.txt)
```{{execute T2}}

<br>

## Revoke the Parent Token

Log back in with `root` token:

```
vault login root
```{{execute T2}}

Execute the following command to revoke the parent token:

```
vault token revoke $(cat parent_token.txt)
```{{execute T2}}

Try running commands with child token:

```
vault token lookup $(cat child_token.txt)
```{{execute T2}}

This should failed because the child token was revoked when its parent got revoked.
