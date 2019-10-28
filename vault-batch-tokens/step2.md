Now, let's login with the batch token:

```
clear
vault login $(cat token.txt)
```{{execute T1}}

Try writing some secrets to the token's Cubbyhole:

```
vault write cubbyhole/token value="1234567890"
```{{execute T1}}

Batch token has no Cubbyhole; therefore, you received an error:

```
Error writing data to cubbyhole/token: Error making API request.

URL: PUT http://127.0.0.1:8200/v1/cubbyhole/token
Code: 400. Errors:

* cubbyhole operations are only supported by "service" type tokens
```

Let's try creating a child token:

```
vault token create -policy=default
```{{execute T1}}

Batch token **cannot** create child tokens even if its policy grants permission

```
Error creating token: Error making API request.

URL: POST http://127.0.0.1:8200/v1/auth/token/create
Code: 400. Errors:

* batch tokens cannot create more tokens
```

Now, log back in with `root` token:

```
vault login root
```{{execute T1}}

Execute the following command to try revoking the batch token:

```
vault token revoke $(cat token.txt)
```{{execute T1}}

Batch tokens have an explicit TTL that they **cannot** be renewed nor revoked before reaching its TTL.

```
Error revoking token: Error making API request.

URL: PUT http://127.0.0.1:8200/v1/auth/token/revoke
Code: 400. Errors:

* batch tokens cannot be revoked
```

Batch tokens have a limited features; however, they are more desirable when you
have stateless microservices requesting a large number of client tokens in any
given moment.



`clear`{{execute T1}}
