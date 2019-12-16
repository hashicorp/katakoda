The **Role ID** and **Secret ID** are like a username and password that a machine or app uses to authenticate.

Now, you need to fetch the Role ID and Secret ID of a role. To read the role ID:

```
vault read auth/approle/role/<ROLE_NAME>/role-id
```

Execute the following command to read the Role ID for `jenkins` and store the returned value in a file named, `role_id.txt`:

```
vault read -format=json auth/approle/role/jenkins/role-id \
      | jq -r ".data.role_id" > role_id.txt
```{{execute T1}}

The `role-id` is equivalent to username or user ID; therefore, it does not change for the life of the `jenkins` role. Re-run the command and compare the value stored in `role_id.txt`{{open}}.

```
vault read auth/approle/role/jenkins/role-id
```{{execute T1}}

```
more role_id.txt
```{{execute T1}}

Next, to read the secret ID:

```
vault read auth/approle/role/<ROLE_NAME>/secret-id
```

To generate the secret ID for `jenkins` role and store the returned value in a file (`secret_id.txt`), execute the following command:

```
vault write -f -format=json auth/approle/role/jenkins/secret-id \
      | jq -r ".data.secret_id" > secret_id.txt
```{{execute T1}}

> NOTE: The `-f` flag forces the `write` operation to continue without any data values specified. Or you can set [parameters](https://www.vaultproject.io/api/auth/approle/index.html#generate-new-secret-id) such as `cidr_list`.

The secret ID is equivalent to password; therefore, a unique value would be generated every time you request. It can be response wrapped and may have TTL and number of use constraints.
