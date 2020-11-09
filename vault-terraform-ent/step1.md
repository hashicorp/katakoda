**Scenario introduction**

Vault administrators must manage multiple Vault environments. The test servers get destroyed at the end of each test cycle and a new set of servers must be provisioned for the next test cycle. To automate the Vault server configuration, you are going to use Terraform to provision the following Vault resources.

| Type                    | Name        | Description                                                                                        |
| ----------------------- | ----------- | -------------------------------------------------------------------------------------------------- |
| namespace               | finance     | A namespace dedicated to the finance organization                                                  |
| namespace               | engineering | A namespace dedicated to the engineering organization                                              |
| namespace               | education   | A namespace dedicated to the education organization                                                |
| namespace               | training    | A child-namespace under `education` dedicated to the training team                                 |
| namespace               | vault_cloud | A child-namespace under `education/training` dedicated to the vault_cloud team                     |
| namespace               | engineering | A child-namespace under `education/training` dedicated to the boundary team                        |
| ACL Policy              | admins      | Sets policies for the admin team                                                                   |
| ACL Policy              | fpe-client  | Sets policies for clients to encode/decode data through transform secrets engine                   |
| auth method             | userpass    | Enable and create a user, "student" with `admins` and `fpe-client` policies                        |
| secrets engine          | kv-v2       | Enable kv-v2 secrets engine in the `finance` namespace                                             |
| secrets engine          | transform   | Enable transform secrets engine at `transform`                                                     |
| transformation          | ccn-fpe     | Transformation to perform format preserving encryption (FPE) transformation on credit card numbers |
| transformation template | ccn         | Define the data format structure for credit card numbers                                           |
| alphabet                | numerics    | Set of allowed characters                                                                          |

The `admins` policy must be created in all namespaces: `root`, `finance`, and `engineering`. The expected admin tasks are the same across the namespaces.


## Examine provided Terraform files

Following Terraform files are provided:

#### main.tf

`main.tf`{{open}} defines two provider blocks each pointing to a different namespace: finance and engineering. This allows you to leverage multiple namespaces during the Vault configuration.

From line 41, it defines nested namespaces as shown below.

```
├── education
│   └── training
│       ├── boundary
│       └── vault_cloud
├── engineering
└── finance
```

First, create the top-level namespace, `education` namespace. To create a child namespace under `education`, specify `provider` which points to `education` namespace provider. Similarly, specify `provider` which points to `training` to create child namespaces, `education/training/vault_cloud` and `education/training/boundary`.

#### policies.tf

`policies.tf`{{open}} creates **admins** and **eaas-client** policies based on the `policies/admin-policy.hcl`{{open}} and `policies/fpe-client-policy.hcl`{{open}} file respectively. The admins policy gets created in the `root`, `finance`, and `engineering` namespaces. The fpe-client policy gets created in the `root` namespace.

#### auth.tf

`auth.tf`{{open}} enables userpass auth method and creates a user, `student` with password, `changeme`.

#### secrets.tf

`secrets.tf`{{open}} enables `kv-v2` and `transform` secrets engines.

> **NOTE:** Terraform Vault Provider **v2.12.0** or later is required.  The details about the transformation, template, alphabet, and role are out of scope for this tutorial. If you are not familiar with Transform secrets engine, go through the [Transform Secrets Engine tutorial](https://www.katacoda.com/hashicorp/scenarios/vault-transform).


## Run Terraform

Set the `VAULT_ADDR` environment variable with value.

```
export VAULT_ADDR="http://127.0.0.1:8200"
```{{execute T1}}


Set the `VAULT_TOKEN` environment variable with value, `root`.

```
export VAULT_TOKEN=root
```{{execute T1}}

Execute the following Terraform command to pull the Vault provider plugin.

```
terraform init
```{{execute T1}}

Execute the following command to calculate what changes will be made based on the terraform file (`main.tf`).

```
terraform plan
```{{execute T1}}

The `plan` output reports what resources will be created, changed, or destroyed. Since this is the first time running Terraform against this Vault instance, there is nothing to change or destroy.

```
Plan: 14 to add, 0 to change, 0 to destroy.
```

Finally, execute the plan using the `terraform apply` command.

```
terraform apply -auto-approve
```{{execute T1}}

After the successful execution, the output should contain the following message:

```
Apply complete! Resources: 14 added, 0 changed, 0 destroyed.
```
