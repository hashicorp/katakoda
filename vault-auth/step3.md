Authenticate using the username and password you just created.

The command would be:

```
vault login -method=userpass username=<user_name> password=<password>
```

Execute the following command to login:

```
vault login -method=userpass username="student01" password="training"
```{{execute}}

When you successfully authenticate with Vault using your username and password, Vault returns a **token**.  From then on, you can use this token to make API calls and/or run CLI commands.


You should be able to execute the following command successfully:

```
vault kv put secret/training course_id="Vault-101"
```{{execute}}

However, the `base` policy does not grant any permission on `sys/policy` that the following command will throw **permission denied** error:

```
vault policy read base
```{{execute}}
