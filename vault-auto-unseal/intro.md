![Vault logo](./assets/Vault_Icon_FullColor.png)

When a Vault server is started, it starts in a [**_sealed_**](https://www.vaultproject.io/docs/concepts/seal.html) state and it does not know how to decrypt data. Before any operation can be performed on the Vault, it must be unsealed. Unsealing is the process of constructing the master key necessary to decrypt the data encryption key.

Vault supports opt-in automatic unsealing via cloud technologies: **AliCloud KMS**, **Amazon KMS**, **Azure Key Vault**, **Google Cloud KMS** as well as **Transit Secrets Engine**. This feature enables operators to delegate the unsealing process to trusted cloud providers to ease operations in the event of partial failure and to aid in the creation of new or ephemeral clusters.

![](./assets/vault-autounseal-2.png)

This scenario demonstrates how to [auto-unseal Vault with Transit Secrets Engine](https://www.vaultproject.io/docs/configuration/seal/transit.html).

In this lab, you are going to perform the following tasks:

1. Configure Auto-unseal Key Provider
1. Configure Auto-unseal
1. Audit the incoming request


To learn more about the auto-unseal feature, refer to the following:

- [Auto-unseal using AWS KMS](https://learn.hashicorp.com/vault/day-one/ops-autounseal-aws-kms)
- [Auto-unseal using Azure Key Vault](https://learn.hashicorp.com/vault/day-one/autounseal-azure-keyvault)
- [Auto-unseal using GCP Cloud KMS](https://learn.hashicorp.com/vault/operations/autounseal-gcp-kms)
- [Auto-unseal using Transit Secrets Engine](https://learn.hashicorp.com/vault/day-one/autounseal-transit)
