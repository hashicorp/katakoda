### Log into the Azure CLI

First, you need to login to the Azure CLI using the login
command provided by your instructor. The command will be similar
to this example.

```plaintext
az login \
  --service-principal
  --username <appId> \
  --password hashiconf \
  --tenant <tenant>
```

You will receive output like the following.

```plaintext
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": REDACTED,
    "id": REDACTED,
    "isDefault": true,
    "managedByTenants": [
      {
        "tenantId": REDACTED
      }
    ],
TRUNCATED
```

### Install the HCS on Azure extension

Click below to install the HCS on Azure extension for the Azure CLI.
This extension is required to manage HCS on Azure from the command line.

`az extension add --source https://releases.hashicorp.com/hcs/0.3.0/hcs-0.3.0-py2.py3-none-any.whl`{{execute T1}}

Click below to when prompted to confirm installation.

`y`{{execute T1}}