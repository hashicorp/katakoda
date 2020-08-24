Connect to the target Vault server.

Export an environment variable for the `vault` CLI to address the target Vault server.

```shell
export VAULT_ADDR=http://0.0.0.0:8200
```{{execute}}

View the policies required to perform the scenario.

```shell
cat scenario-policy.hcl
```{{execute}}

Login with `userpass` authentication with the `scenario-user`.

```shell
vault login -method=userpass \
  username=scenario-user \
  password=scenario-password
```{{execute}}

The environment is ready. Proceed to the next step.