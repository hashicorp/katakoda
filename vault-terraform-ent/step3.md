**Scenario introduction**

Vault administrators must manage multiple Vault environments. The test servers get destroyed at the end of each test cycle and a new set of servers must be provisioned for the next test cycle. To automate the Vault server configuration, you are going to use Terraform to provision the following Vault resources.

| Type           | Name         | Description                           |
|----------------|--------------|---------------------------------------|
| namespace      | finance      | A namespace dedicated to the finance organization |
| namespace      | engineering  | A namespace dedicated to the engineering organization |
| ACL Policy     | admins       | Sets policies for the admin team  |
| ACL Policy     | fpe-client   | Sets policies for clients to encode/decode data through transform secrets engine  |
| auth method    | userpass     | Enable and create a user, "student" with `admins` and `fpe-client` policies |
| secrets engine | kv-v2        | Enable kv-v2 secrets engine in the `finance` namespace  |
| secrets engine | transform    | Enable transform secrets engine at `transform`  |
| transformation | ccn-fpe      | Transformation to perform format preserving encryption (FPE) transformation on credit card numbers |
| transformation template | ccn | Define the data format structure for credit card numbers  |
| alphabet       | numerics     | Set of allowed characters    |

The `admins` policy must be created in all namespaces: `root`, `finance`, and `engineering`. The expected admin tasks are the same across the namespaces.


## Run Terraform

First, change the working directory to `enterprise`.

```
cd ../enterprise
```{{execute T1}}

Examine the `enterprise/main.tf`{{open}} file contents.

It creates `admins` policy based on the `enterprise/policies/admin-policy.hcl`{{open}} file. Similarly, creates `eaas-client` policy based on the `enterprise/policies/fpe-client-policy.hcl`{{open}} file.

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
