Execute the following command to create a policy:

```
vault policy write base base.hcl
```{{execute T1}}

Run the following command to list existing policies:

```
vault policy list
```{{execute T1}}

The list should include the `base` policy you just created.

The following command displays the policy you just created:

```
vault policy read base
```{{execute T1}}


<br>

## Create a policy via Vault UI

Let's explore the Vault UI.

1. Click on the **Vault UI** tab to launch the Vault UI.

  ![](https://education-yh.s3-us-west-2.amazonaws.com/screenshots/katacoda-vault-ui.png)

1. Enter **`root`** in the **Token** text field and then click **Sign In**.

1. Click the **Policies** tab on the top menu, and then select **Create ACL policy**.

  ![](https://education-yh.s3-us-west-2.amazonaws.com/screenshots/vault-policy-ui.png)

1. Open the `admin.hcl`{{open}} file and copy its content, and then paste it into the **Policy** text field in the UI.

1. Enter `admin` in the **Name** field.

  ![](https://education-yh.s3-us-west-2.amazonaws.com/screenshots/vault-policy-ui-2.png)

1. Click **Create policy** to create a new `admin` policy.
