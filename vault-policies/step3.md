Now, create a token attached to the `base` policy so that you can test it.

You are going to run the `vault token create` command.  To view the full list of optional parameters for the operation, run the following command:

```
vault token create -h
```{{execute}}

Create a new token, and save the generated token in a file named, `token.txt`:

```
clear
vault token create -policy="base" \
    -format=json | jq -r ".auth.client_token" > token.txt
```{{execute}}

<br>

## Authenticate with Base Token

Let's login with newly generated `token` (`token.txt`{{open}}).  The command is:

```
vault login $(cat token.txt)
```{{execute}}

> **NOTE:** A built-in policy, `default`, is attached to all tokens and provides common permissions.
