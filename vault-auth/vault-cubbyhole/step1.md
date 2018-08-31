To better demonstrate the cubbyhole secret engine, first create a **non-privileged** token.

```
vault token create -policy=default \
    -format=json | jq -r ".auth.client_token" > token.txt
```{{execute T2}}


Now, log into Vault using the newly generated token:

```
vault login $(cat token.txt)
```{{execute T2}}

Your token has `default` policy attached which does **not** give you access to any of the secret engines except cubbyhole. You can test that by running the following command:

```
vault kv put secret/test password="my-password"
```{{execute T2}}

This should throw **permission denied** error.

<br>
## Write Secrets in Cubbyhole

Execute the following command to write secret in the `cubbyhole/private` path:

```
vault write cubbyhole/private mobile="123-456-7890"
```{{execute T2}}


Read back the secret you just wrote. It should return the secret.

```
vault read cubbyhole/private
```{{execute T2}}

<br>

## Try as a root

Log back in with root token:

```
vault login root
```{{execute T2}}


Now, try to read the `cubbyhole/private` path.

<br>

#### What response did you receive?

Cubbyhole secret backend provide an isolated secrete storage area for an individual token where **no other token** can violate.

```
vault read cubbyhole/private
```{{execute T2}}
