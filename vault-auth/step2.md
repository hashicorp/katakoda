Before creating a user, let's create a policy named, `base`.

```
vault policy write base base.hcl
```{{execute T1}}

To review the created policy:

```
vault policy read base
```{{execute T1}}



## Create a User

The command to create a new user:

```
vault write auth/<userpass_mount_path>/users/<username> password=<password> policies=<list_of_policies>
```

The method lowercases all submitted usernames (e.g. _Mary_ and _mary_ are the same entry).

Let's create your first user.

- Username: `student01`
- Password: `training`
- Policy: `base`

```
vault write auth/userpass/users/student01 \
            password="training" policies="base"
```{{execute T1}}


Notice that the username is a part of the path and the two parameters are password (in plain-text) and the list of policies as comma-separated value.


You can verify the setup by reading it from the path:

```
vault read auth/userpass/users/student01
```{{execute T1}}

Notice that the password is NOT included in the response.

<br>
If you wish to list the users created, execute the following command:

```
vault list auth/userpass/users
```{{execute T1}}
