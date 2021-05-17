```
               __
    ..=====.. |==|      ___________________
    ||     || |= |     < Database, please! >
 _  ||     || |^*| _    -------------------
|=| o=,===,=o |__||=|
|_|  _______)~`)  |_|
    [=======]  ()
```

The web application needs access to database

Login with the `apps` user.

```shell
vault login -method=userpass \
  username=apps \
  password=apps-password
```{{execute}}

## Perform action

Attempt to read credentials from the database role

```shell
vault read database/creds/readonly
```{{execute}}

## Discover the policy

### Error message

This error message is displayed when the command is executed.

```
Error reading database/creds/readonly: Error making API request.

URL: GET http://0.0.0.0:8200/v1/database/creds/readonly
Code: 403. Errors:

* 1 error occurred:
        * permission denied
```

The message displays the path that is required.

### Audit Logs

The file audit log writes JSON objects to the log file. The `jq` command parses,
filters and presents that data to you in a more digestable way.

Show the details of the last logged object.

```shell
cat vault_audit.log | jq -s ".[-1]"
```{{execute}}

Show the error message of the last logged object.

```shell
cat vault_audit.log | jq -s ".[-1].error"
```{{execute}}

Show the request of the last logged object.

```shell
cat vault_audit.log | jq -s ".[-1].request"
```{{execute}}

Show the request path and operation.

```shell
cat vault_audit.log | jq -s ".[-1].request.path,.[-1].request.operation"
```{{execute}}


### API Documentation

Select the database tab.

Read the https://www.vaultproject.io/api-docs/secret/databases#read-role

Translate GET to `read`.
Translate `/secret/data/:path` to `/database/creds/readonly`.

## Define the policy

```hcl
path "database/creds/readonly" {
  capabilities = [ "read" ]
}
```

Append the policy definition to the local policy file

```shell
echo "
path \"database/creds/readonly\" {
  capabilities = [ \"read\" ]
}" >> apps-policy.hcl
```{{execute}}

## Apply the policy

Login as root.

```shell
vault login root
```{{execute}}

Update the `apps-policy`.

```shell
vault policy write apps-policy apps-policy.hcl
```{{execute}}

## Test the policy

Login with the `apps` user.

```shell
vault login -method=userpass \
  username=apps \
  password=apps-password
```{{execute}}

Read the database credentials.

```shell
vault read database/creds/readonly
```{{execute}}