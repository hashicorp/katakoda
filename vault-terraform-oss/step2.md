Verify to make sure that Vault has been configured as defined in the `main.tf`.

List existing policies to make sure that `admins` and `eaas-client` policies were created.

```
vault policy list
```{{execute T1}}

List enabled secrets engines to verify that kv-v2 and transit secrets engines are enabled.

```
vault secrets list
```{{execute T1}}

## Verify the student user

1. Click on the **Vault UI** tab to launch the Vault UI.

  ![](./assets/katacoda-vault-ui.png)

1. Select **Username** from the **Method** drop-down list, and enter `student` in the **Username** text field and `changeme` in the **Password** text field.

  ![](./assets/vault-ui-userpass.png)

1. Click **Sign In**. You should see that `kv-v2` and `transit` are listed.

  ![](./assets/vault-ui-secrets.png)

1. Select **transit > payment**. The Terraform enabled the `transit` secrets engine and created the `payment` key.

1. Select the **Key action**.

1. With **Encrypt** selected, enter some text in the **Plaintext** field (e.g. `my-long-secrets`).

1. Click **Encode to base64**, and then **Encrypt**. This returns you the ciphertext.

  ![](./assets/vault-ui-transit.png)

  > **NOTE:** To learn more about the `transit` secrets engine, visit to the [Vault Encryption as a Service](https://www.katacoda.com/hashicorp/scenarios/vault-transit) tutorial.

1. Select **Secrets** to return to the **Secrets Engines** list.

  ![](./assets/vault-ui-secrets-0.png)

1. Select `kv-v2` and click **Create secret**.

1. Enter `training/course` in the **Path for this secret** text field. In the key text field under **Version data**, enter `Name`, and `Codify Management of Vault` in the value text field.

  ![](./assets/vault-ui-kv-v2.png)

1. Click **Save**.

> **NOTE:** The details about how transit secrets engine works are out of scope for this tutorial. If you are not familiar with transit secrets engine, read the [Encryption as a Service: Transit Secrets
Engine](https://www.katacoda.com/hashicorp/scenarios/vault-transit) tutorial.


## Clean up

When you are done exploring, you can undo the configuration made by Terraform.

First log back in with the client token used to run the terraform commnands.

```
vault login root
```{{execute T1}}

Destroy the Vault resources created by Terraform.

```
terraform destroy -auto-approve
```{{execute T1}}

Remove the terraform state files.

```
rm *.tfstate.*
```{{execute T1}}
