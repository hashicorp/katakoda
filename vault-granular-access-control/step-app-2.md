```
               __
    ..=====.. |==|     ________________
    ||     || |= |    < Database, plz! >
 _  ||     || |^*| _   ----------------
|=| o=,===,=o |__||=|
|_|  _______)~`)  |_|
    [=======]  ()
```

The application requires access to a database. These credentials are managed by
the database secrets engine at the path `database` in a role named `readonly`.

Login with the `root` user.

```shell
vault login root
```{{execute}}

Get the database credentials from the database role.

```shell
vault read database/creds/readonly
```{{execute}}

## As the application

The policies defined for `apps` does not grant it the capability to perform this
operation.

Login with the `apps` user.

```shell
vault login -method=userpass \
  username=apps \
  password=apps-password
```{{execute}}

Fail to get database credentials from the database role.

```shell
vault read database/creds/readonly
```{{execute}}

## Discover the policy change required

Login with the `root` user.

```shell
vault login root
```{{execute}}

#### 1️⃣ with the CLI flags

Run the command with the `-output-curl-string` flag.

#### 2️⃣ with the audit logs

The audit log maintains a list of all requests handled by Vault.

Get the database credentials from the database role.

```shell
vault read database/creds/readonly
```{{execute}}

Show the last logged object.

```shell
cat log/vault_audit.log | jq -s ".[-1]"
```{{execute}}

The object describes the time, the authorized token, the request, and the
response.

Show the request of the last logged object.

```shell
cat log/vault_audit.log | jq -s ".[-1].request"
```{{execute}}

The request describes the **operation** that was performed on the **path**.

Show the request's path and the request's operation.

```shell
cat log/vault_audit.log | jq -s ".[-1].request.path,.[-1].request.operation"
```{{execute}}

The response displays the path `"database/creds/readonly"` and the operation
`"read"`.

## Enact the policy

What policy is required to meet this requirement?

1. Define the policy in the local file.
2. Update the policy named `apps-policy`.
3. Test the policy with the `apps` user.
