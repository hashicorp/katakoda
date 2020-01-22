Now, create a token attached to the `base` policy so that you can test the policy.

Execute the following command to create a new token and save the generated token in a file named, `token.txt`:

```
vault token create -policy="base" \
    -format=json | jq -r ".auth.client_token" > token.txt
```{{execute T1}}

Now, login with newly generated `token` (`token.txt`{{open}}).  The command is:

```
vault login $(cat token.txt)
```{{execute T1}}

Notice that the `base` policy is listed.

```
Key                  Value
---                  -----
...
token_policies       ["base" "default"]
identity_policies    []
policies             ["base" "default"]
```

> **NOTE:** A built-in policy, `default`, is attached to all tokens and provides common permissions.


Remember that the `base` policy only permits CRUD operations on `secret/training_*` path.  

The following command **should fail** with **"permission denied"** error since the `base` policy doesn't define any permission on the `secret/apikey` path:

```
vault kv put secret/apikey key="my-api-key"
```{{execute T1}}

Now, the following command should execute **successfully**:

```
vault kv put secret/training_test password="p@ssw0rd"
```{{execute T1}}

The policy was written for the `secret/training_*` path so that you can write on `secret/training_test`, `secret/training_dev`, `secret/training_prod`, etc.

You should be able to read back the data:

```
vault kv get secret/training_test
```{{execute T1}}

Now, pass a different password value to update it. This should **FAIL** because the base policy only grants **create** and **read** .  With absence of **update** permission, this operation fails.

```
vault kv put secret/training_test password="password1234"
```{{execute T1}}

<br>

## Question

What happens when you try to write data in `secret/training_` path?

Will this work?
￼
<br>

## Answer

This is going to work.

```
vault kv put secret/training_ year="2018"
```{{execute T1}}

However, this is **NOT** because the path is a regular expression.  Vault's paths use a radix tree, and that "\*" can only come at the end.  It matches zero or more characters but not because of a regex.

<br>

Now, try the following command:

```
vault kv put secret/team-eng/apikey api_key="123456789"
```{{execute T1}}

The path `secret/team-eng/apikey` matches the `secret/<string>/apikey` pattern, so the command should execute successfully.

Since the policy allows **delete** operation, the following command should execute successfully as well:

```
vault kv delete secret/team-eng/apikey
```{{execute T1}}
