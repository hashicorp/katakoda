Verify to make sure that Vault has been configured as defined in the `main.tf`.

List existing transformations.

```
vault list transform/transformation
```{{execute T1}}

Read the `ccn-fpe` transformation details.

```
vault read transform/transformation/ccn-fpe
```{{execute T1}}

List existing transformation templates.

```
vault list transform/template
```{{execute T1}}

Read the `ccn` transformation template definition.

```
vault read transform/template/ccn
```{{execute T1}}

<br />

## Launch Vault UI

Click on the **Vault UI** tab to launch the Vault UI.

![](./assets/katacoda-vault-ui.png)

Enter `root` in the **Token** text field and click **Sign in**.

Verify that `finance` and `engineering` namespaces exist. The green check-mark indicates that you are currently logging into the `root` namespace.

![Namespaces](./assets/vault-codify-mgmt-1.png)

Switch to the **engineering** namespace and verify that `admins` policy exists.

![Policies](./assets/vault-codify-mgmt-3.png)

Select the `education` namespace and verify that `training` namespace exists.

![Secrets Engine](./assets/vault-codify-mgmt-15.png)

Select the `training` namespace and verify that `vault_cloud` and `boundary` namespaces exist.

![Secrets Engine](./assets/vault-codify-mgmt-16.png)

Switch to the **finance** namespace and verify that `kv-v2` secrets engine is enabled.

![Secrets Engine](./assets/vault-codify-mgmt-4.png)

Click the **Policies** tab to verify that `admin` policy exists.

Now, return to the **root** namespace and verify that `transform` secrets engine is enabled.

![Secrets Engine](./assets/vault-codify-mgmt-5.png)

Click the **Policies** tab. Verify that `admins` and `fpe-client` policies exist.

![Policies](./assets/vault-codify-mgmt-2.png)

Sign out of the Vault UI.

![Sign out](./assets/vault-codify-mgmt-7.png)

In the sign in page, select **Username** auth method, enter `student` in the **Username** text field, and `changeme` in the **Password** text field.

![Sign in](./assets/vault-codify-mgmt-8.png)

Click the Vault CLI shell icon (`>_`) to open a command shell. Execute `vault write transform/encode/payments value=1111-2222-3333-4444` to verify that the user, `student` can encode a credit card number using the payment role.

![Sign in](./assets/vault-codify-mgmt-9.png)
