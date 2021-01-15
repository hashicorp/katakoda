Connect to the target Vault server.

Export an environment variable for the `vault` CLI to address the target Vault server.

```shell
export VAULT_ADDR=http://localhost:8200
```{{execute}}

View the policies required to perform **admin** responsibilities in the
scenario.

```shell
cat ~/admin-policy.hcl
```{{execute}}

Login with the `admin` user using the `userpass` authentication method.

```shell
vault login -method=userpass \
  username=admin \
  password=admin-password
```{{execute}}

The environment is ready. Proceed to the next step.