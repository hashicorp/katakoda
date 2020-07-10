This scenario gave you a quick introduction to the Terraform Vault plugin.

Terraform is an **Infrastructure as Code** tool, so treat your Terraform files as your code. This means that you can now automate the Vault cluster management process by plug it into your preferred CI/CD tool such as CircleCI.

For example, `git commit` triggers the CircleCI to spin up a Docker image running Vault in development mode, and execute the Terraform against it. If the Vault configuration was successful, you can roll it out to the staging cluster, etc. Otherwise, fix the Terraform files and repeat the process.

![](./assets/codify-mgmt-vault.png)

This significantly reduces human errors as well as inconsistencies across Vault environments. Terraform can be your working documentation of any change in the Vault server configuration.


### Resources:

- [Learn Terraform](https://learn.hashicorp.com/terraform)
- [Terraform Vault Provider](https://www.terraform.io/docs/providers/vault/index.html)
- [Best Practices for Using HashiCorp Terraform with HashiCorp Vault](https://www.hashicorp.com/resources/best-practices-using-hashicorp-terraform-with-hashicorp-vault)
