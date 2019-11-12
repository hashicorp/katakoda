Verify to make sure that Vault has been configured as defined in the `main.tf`.

- `training` policy was created
- `userpass` auth method is enabled and you can login as `student`
- Key/Value v2 secrets engine is enabled at `kv-v2`
- Transit secrets engine is enabled at `transit` and `payment` key exists
- The user `student` has the permissions granted by the `training` policy


First, check to verify that `training` policy has been created:

```
vault policy list
```{{execute T1}}

The list should contain the `training` policy, and read it to verify its defined rules.

```
vault policy read training
```{{execute T1}}

<br>

## Verify the student user

1. Launch the [Vault Web UI](https://[[HOST_SUBDOMAIN]]-8200-[[KATACODA_HOST]].environments.katacoda.com/).

1. Select **Username** from the **Method** drop-down list, and enter `student` in the **Username** text field and `changeme` in the **Password** text field.

  ![](https://education-yh.s3-us-west-2.amazonaws.com/screenshots/vault-ui-userpass.png)

1. Click **Sign In**. You should see that `kv-v2` and `transit` are listed.

  ![](https://education-yh.s3-us-west-2.amazonaws.com/screenshots/vault-ui-secrets.png)

1. Select **transit > payment**. The Terraform enabled the `transit` secrets engine and created the `payment` key.

1. Select the **Key action**.

1. With **Encrypt** selected, enter some text in the **Plaintext** field (e.g. `my-long-secrets`).

1. Click **Encode to base64**, and then **Encrypt**.

  ![](https://education-yh.s3-us-west-2.amazonaws.com/screenshots/vault-ui-transit.png)

  This returns you the ciphertext.

1. Select **Secrets** to return to the **Secrets Engines** list.

1. Select `kv-v2` and click **Create secret**.

1. Test to see that you can create some data.

  ![](https://education-yh.s3-us-west-2.amazonaws.com/screenshots/vault-ui-kv-v2.png)
