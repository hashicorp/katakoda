1.  Launch the [Microsoft Azure Portal](https://portal.azure.com/) and sign in.

1.  Select **Azure Active Directory** and select **Properties**.
    ![Azure Active Directory](azure-active-directory.png)

1.  Copy and store the **Tenant ID**.
    ![Tenant ID](azure-default-directory-tenant-id.png)

1.  From the side navigation, select **App registrations**.
    ![App registrations](azure-default-directory-app-registrations.png)

1.  Select **New registrations**.
    ![New App registration](azure-default-directory-app-registrations-new.png)

1.  Enter `education` in the **Name** field.

1.  Click **Register**.

1.  Copy and store the generated **Application (client) ID**.
    ![Client ID](vault-autounseal-azure-3.png)

1.  From the side navigation, select **Certificate & secrets**.

1.  Under the **Client secrets**, click **New client secret**.

1.  Enter a description in the **Description** field.
    ![Azure portal](vault-azure-secrets-1.png)

1.  Click **Add**.

1.  Copy and store the client secret value.
    ![Azure directory application secret
    value](azure-app-created-secret-value.png)

1.  From the side navigation, click **API permissions**.
    ![Azure directory application API
    permissions](azure-default-directory-app-api-permissions.png)

1.  Under **Configured permissions**, click **Add a permission**.
    ![Azure directory application add a
    permission](azure-default-directory-api-add-permission.png)

1.  Under **Supported legacy APIs**, click **Azure Active Directory Graph**.
    ![Azure directory app perms
    legacy](azure-default-directory-api-azure-active-dir-graph.png)

1.  Click **Delegated permissions**.
    ![Azure Active Directory Graph](vault-azure-secrets-3.png)

1.  Expand **User**, select the check-box for **User.Read**.

1.  Click **Application permissions**.
    ![Azure directory app application permissions](azure-directory-api-azure-app-permissions.png)

1.  Expand **Application**, select the check-box for
    **Application.ReadWrite.All**.

1.  Expand **Directory**, select the check-box for **Directory.ReadWrite.All**.

1.  Click **API permissions**.

1.  Click **Grant admin consent for azure** to grant the permissions.
    ![Azure directory app permissions grant admin
    consent](azure-directory-api-azure-app-grant-admin-consent.png)

1.  Navigate to the
    [**Subscriptions**](https://portal.azure.com/#blade/Microsoft_Azure_Billing/SubscriptionsBlade)
    blade.

1.  Copy and store the **Subscription ID**.
    ![Subscription ID](vault-autounseal-azure-1.png)

1.  Click the name of the subscription.

1.  From the side navigation, click **Access control (IAM)**.
    ![Azure subscription access control](azure-subscription-access-control.png)

1.  Click **Add** to expand the menu.

1.  Click **Add a role assignment**.
    ![Azure subscription access add role assignment](azure-subscription-add-role-assignment.png)

1.  Choose `Owner` from the **Role** select field.

1.  Choose `User, group, or service prinicipal` from the **Assign Access To**
    select field.

1.  Enter the application name or application id in the **Select** field.

1.  Click the application when it is displayed.
    ![Azure subscription access role assignmet to
    app](azure-subscription-role-assignment-to-app.png)

1.  Click **Save**.

The application is created with the correct permissions and you have these
identifiers and credentials:

- Tenant ID
- Client ID
- Client Secret
- Subscription ID

The secrets engine generates credentials within an Azure resource group.

1. Launch the [Microsoft Azure Portal](https://portal.azure.com/) and sign in.

1. Navigate to
    [**Resource groups**](https://portal.azure.com/#blade/HubsExtension/BrowseResourceGroups).

1. Click **Create**.
   ![Resource group create button](azure-resource-group-create-button.png)

1. Choose the subscription from the **Subscription** select field.

1. Enter `vault-education` in the **Resource group** field.
   ![Create resource group vault-education](azure-resource-group-create-vault-education.png)

1. Click **Review + create**.

   The view changes to display the review page.

1. Click **Create**.

The resource group `vault-education` is created.
