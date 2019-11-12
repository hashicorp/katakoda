<img src="https://education-yh.s3-us-west-2.amazonaws.com/Vault_Icon_FullColor.png" alt="Logo"/>


Many organizations leverage [Terraform](https://www.terraform.io) to spin up a Vault cluster. Once a cluster is up and running, Vault admin would have to perform some initial setups before other teams and applications can start interacting with Vault (e.g. enable and configure auth methods, create base policies, enable K/V secrets engine). Terraform is a powerful tool such that those initial setups can be done by Terraform and the task becomes repeatable.

In this tutorial, you are going to explorer how you can codify the Vault configuration using Terraform:

- Use Terraform file to configure Vault
- Verify the Configuration
