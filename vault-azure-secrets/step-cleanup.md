The Azure credentials created to configure the secrets engine should be deleted
if they are no longer requried.

1.  Launch the [Microsoft Azure Portal](https://portal.azure.com/) and sign in.

1.  Navigate to [Azure Active
    Directory](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview).

1.  From the side navigation, select **App registrations**.

1.  Click the **education** application.

1.  From the application overview, click **delete**.

1.  Select **Yes** to delete the application.

The application is deleted.

The secrets engine generated credentials within the `vault-education` Azure
resource group. Any credentials that were no revoked should be deleted if they
are no longer required.

1.  Launch the [Microsoft Azure Portal](https://portal.azure.com/) and sign in.

1.  Navigate to
    [**Resource
    groups**](https://portal.azure.com/#blade/HubsExtension/BrowseResourceGroups).

1.  Click the **vault-education** resource group.

1.  From the resource group overview, click **Delete resource group**.

1.  Enter `vault-education` in the `TYPE THE RESOURCE GROUP NAME:` field.

1.  Click **Delete**.

The resource group is deleted.