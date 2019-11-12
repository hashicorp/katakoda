Once a Vault server is started, initialized and unsealed, the first step is to perform initial setup which typically includes:

- Create ACL policies to control access to Vault
- Enable auth methods for people or system to authenticate with Vault
- Enable secrets engines

You may have multiple Vault environments: Dev, QA, Staging, Production, etc.  To reduce the operation overhead to repeat the same initial setups, you can leverage Terraform. Terraform is a ***Infrastructure as Code*** tool which enables you to build, change and configure your infrastructure.

First, login with root token.

> Click on the command (`⮐`) will automatically copy it into the terminal and execute it.

```
vault login root
```{{execute T1}}


Open the `main.tf`{{open}} file to review its content. Notice that it pulls the `vault` provider.

```
provider "vault" { }
```

Examine the provided Terraform file. Refer to the [Terraform documentation](https://www.terraform.io/docs/providers/vault/index.html) as needed to understand. The `main.tf` creates the following:

1. `training` policy file (`training.hcl`)
1. Create a `training` policy based on the policy file
1. Enable `userpass` auth method
1. Create a user named, `student` with password `changeme` with `training` policy attached
1. Enable Key/Value v2 secrets engine at `kv-v2` path
1. Enable Transit secrets engine at `transit` path
1. Create a new encryption key named, `payment`

When you are ready, set the `VAULT_TOKEN` environment variable.

```
export VAULT_TOKEN=root
```{{execute T1}}

Execute the following command to pull Vault provider plugin.

```
terraform init
```{{execute T1}}

Execute the following command to see what changes will be made based on the terraform file.

```
terraform plan
```{{execute T1}}

The `plan` output reports what resources will be created, changed, or destroyed.

```
Plan: 6 to add, 0 to change, 0 to destroy.
```

Finally, execute the following command to configure Vault using Terraform.

```
terraform apply -auto-approve
```{{execute T1}}

After the successful execution, the output should contain the following message:

```
Apply complete! Resources: 6 added, 0 changed, 0 destroyed.
```
