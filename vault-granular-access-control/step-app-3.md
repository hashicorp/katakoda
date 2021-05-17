```
               __
    ..=====.. |==|      _____________________
    ||     || |= |     < Encryption, please! >
 _  ||     || |^*| _    ---------------------
|=| o=,===,=o |__||=|
|_|  _______)~`)  |_|
    [=======]  ()
```

The web application needs access to the transit encryption key

Login with the `apps` user.

```shell
vault login -method=userpass \
  username=apps \
  password=apps-password
```{{execute}}

## Perform action

Attempt to encrypt content with transit key

```shell
vault write transit/encrypt/webapp-auth plaintext=$(base64 <<< "my secret data")
```{{execute}}

## Discover the policy

### Error message

This error message is displayed when the command is executed.

```
Error writing data to transit/encrypt/webapp-auth: Error making API request.

URL: PUT http://0.0.0.0:8200/v1/transit/encrypt/webapp-auth
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

Select the transit tab.

Read the https://www.vaultproject.io/api-docs/secret/transit#encrypt-data

Translate UPDATE to `update`.
Translate `/transit/encrypt/:name` to `/transit/encrypt/webapp-auth`.

## Define the policy

```hcl
path "/transit/encrypt/webapp-auth" {
  capabilities = [ "update" ]
}
```

Append the policy definition to the local policy file

```shell
echo "
path \"transit/encrypt/webapp-auth\" {
  capabilities = [ \"update\" ]
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

Encrypt the content with the transit key.

```shell
vault write transit/encrypt/webapp-auth plaintext=$(base64 <<< "my secret data")
```{{execute}}