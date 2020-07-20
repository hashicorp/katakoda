When you are done exploring, you can undo the configuration made by Terraform.

First log back in with the client token used to run the terraform commnands.

```
vault login $VAULT_TOKEN
```{{execute T1}}

Destroy the Vault resources created by Terraform.

```
terraform destroy -auto-approve
```{{execute T1}}

Remove the terraform state files.

```
rm *.tfstate.*
```{{execute T1}}

-> **NOTE:** To learn more about Terraform, visit [Learn Terraform](/terraform).
