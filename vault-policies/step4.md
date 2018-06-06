Recall that the `base` policy only permits CRUD operations on `secret/training/` path.  

The following command **should fail** with **"permission denied"** error.:

```
vault policy list
```{{execute}}


Similarly, you won't be able to write secrets at `secret/apikey`:

```
vault kv put secret/apikey key="my-api-key"
```{{execute}}

<br>
Finally, the following command should execute **successfully**:

```
vault kv put secret/training_test password="p@ssw0rd"
```{{execute}}

The policy was written for the `secret/training_*` path so that you can write on `secret/training_test`, `secret/training_dev`, `secret/training_prod`, etc.


You should be able to read back the data:

```
vault kv get secret/training_test
```{{execute}}

<br>

Now, pass a different password value to update it.

```
vault kv put secret/training_test password="password1234"
```{{execute}}

> This should fail because the base policy only grants **create** and **read**.  With absence of **update** permission, this operation fails.

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
```{{execute}}

However, this is **NOT** because the path is a regular expression.  Vault's paths use a radix tree, and that "\*" can only come at the end.  It matches zero or more characters but not because of a regex.
