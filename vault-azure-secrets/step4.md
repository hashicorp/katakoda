The applications that require the azure credentials read them from the secret
engine's _edu-app_ role.

View the policies required to perform the **apps** responsibilities in this
scenario.

```shell
cat apps-policy.hcl
```{{execute}}

Login with the `apps` user using the `userpass` authentication method.

```shell
vault login -method=userpass \
  username=apps \
  password=apps-password
```{{execute}}

Read credentials from the `edu-app` azure role.

```shell
vault read azure/creds/edu-app
```{{execute}}

The results display the credentials, its TTL, and the lease ID.
