Once a Vault server is started, initialized and unsealed, the next step is to perform initial setup which typically includes:

- Create ACL policies to control access to Vault
- Enable auth methods for people or system to authenticate with Vault
- Enable secrets engines

You may have multiple Vault environments: Dev, QA, Staging, Production, etc.  Instead of manually repeating the same setups against multiple environments, you can leverage [Terraform](https://www.terraform.io/) to codify it. Terraform is a ***Infrastructure as Code*** tool which enables you to build, change and configure your infrastructure.

First, login with root token.

> Click on the command (`⮐`) will automatically copy it into the terminal and execute it.

```
vault login root
```{{execute T1}}


Open the `main.tf`{{open}} file to review its content. Refer to the [Terraform documentation](https://www.terraform.io/docs/providers/vault/index.html) as necessary. The `main.tf` creates the following:

1. `training` policy file (`training.hcl`)
1. Create a `training` policy based on the policy file
1. Enable `userpass` auth method
1. Create a user named, `student` with password `changeme` with `training` policy attached
1. Enable Key/Value v2 secrets engine at `kv-v2` path
1. Enable Transit secrets engine at `transit` path
1. Create a new encryption key named, `payment`

Execute the following command to list existing policies:

```
vault policy list
```{{execute T1}}

The built-in policies, `default` and `root` are the only policies listed.

Similarly, list the currently enabled auth methods as well as secrets engine:

```
vault auth list
vault secrets list
```{{execute T1}}

The `token` auth method is the only auth method currently enabled. The list of secrets engines does not display neither `kv-v2` or `transit` paths.  

<br>

## Run Terraform

First, set the `VAULT_TOKEN` environment variable with value, `root`.

```
export VAULT_TOKEN=root
```{{execute T1}}

> **NOTE:** Terraform reads the `VAULT_ADDR` and `VAULT_TOKEN` environment variables to connect to your target Vault server/cluster.

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
Plan: 6 to add, 0 to change, 0 to destroy.
```

Finally, execute the plan using the `terraform apply` command.

```
terraform apply -auto-approve
```{{execute T1}}

After the successful execution, the output should contain the following message:

```
Apply complete! Resources: 6 added, 0 changed, 0 destroyed.
```

> **NOTE:** To apply the same configuration to another Vault server/cluster, simply update the `VAULT_ADDR` and `VAULT_TOKEN` values to point to the desired target server/cluster.
