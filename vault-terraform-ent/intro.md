![Vault logo](./assets/Vault_Icon_FullColor.png)


One of the pillars behind the [Tao of Hashicorp](https://www.hashicorp.com/tao-of-hashicorp) is _automation through
codification_.

HashiCorp Terraform is an **infrastructure as a code** which enables the operation team to codify the Vault configuration tasks such as the creation of policies. Automation through codification allows operators to increase their productivity, move quicker, promote repeatable processes, and reduce human error.

This tutorial demonstrates techniques for creating Vault policies and configurations using [Terraform Vault
Provider](https://www.terraform.io/docs/providers/vault/index.html).


This tutorial focuses on codifying the Vault server configuration using Terraform.  To deploy a Vault cluster using Terraform, refer to the [Provision a Best Practices Vault Cluster in AWS](https://github.com/hashicorp/vault-guides/tree/master/operations/provision-vault/best-practices/terraform-aws).


There are two parts in this tutorial:

- Vault **OSS** server configuration using Terraform
- Vault **Enterprise** server configuration using Terraform 


This scenario runs Vault Enterprise version.

> **Important Note:** Without a license, Vault Enterprise server will be sealed after ***30 minutes***. In other words, you have 30 free minutes to explorer the Enterprise features. To explore Vault Enterprise further, you can [sign up for a free 30-day trial](https://www.hashicorp.com/products/vault/trial).
