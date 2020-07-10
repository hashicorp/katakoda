First, login with root token.

> Click on the command (`⮐`) will automatically copy it into the terminal and execute it.

```
vault login root
```{{execute T1}}


## Configure Vault OSS

**Scenario introduction**

Vault administrators must manage multiple Vault environments. The test servers get destroyed at the end of each test cycle and a new set of servers must be provisioned for the next test cycle. To automate the Vault server configuration, you are going to use Terraform to provision the following Vault resources.

| Type           | Name         | Description                           |
|----------------|--------------|---------------------------------------|
| ACL Policy     | admins       | Sets policies for the admin team  |
| ACL Policy     | eaas-client  | Sets policies for clients to encrypt/decrypt data through transit secrets engine  |
| auth method    | userpass     | Enable and create a user, "student" with `admins` and `fpe-client` policies |
| secrets engine | kv-v2        | Enable kv-v2 secrets engine at `kv-v2`  |
| secrets engine | transit      | Enable transit secrets engine at `transit`  |
| encryption key | payment      | Encryption key to encrypt/decrypt data |

It creates `admins` policy based on the `oss/policies/admin-policy.hcl`{{open}} file. Similarly, creates `eaas-client` policy based on the `oss/policies/eaas-client-policy.hcl`{{open}} file.

<br>

## Run Terraform

First, change the working directory to `oss`.

```
cd oss
```{{execute T1}}

Examine the `oss/main.tf`{{open}} file contents.

Set the `VAULT_TOKEN` environment variable with value, `root`.

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
Plan: 7 to add, 0 to change, 0 to destroy.
```

The `terraform apply` command first executes the `plan` command. Therefore, this step is not necessary; however, very useful when you are working on the Terraform files to verify the actions.


Finally, execute the plan using the `terraform apply` command.

```
terraform apply -auto-approve
```{{execute T1}}

After the successful execution, the output should contain the following message:

```
Apply complete! Resources: 7 added, 0 changed, 0 destroyed.
```

> **NOTE:** To apply the same configuration to another Vault server/cluster, simply update the `VAULT_ADDR` and `VAULT_TOKEN` values to point to the desired target server/cluster.
