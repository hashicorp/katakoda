### Install the HCS on Azure extension

Click below to install the HCS on Azure extension for the Azure CLI.
This extension is required to manage HCS on Azure from the command line.

`az extension add --source https://releases.hashicorp.com/hcs/0.3.0/hcs-0.3.0-py2.py3-none-any.whl`{{execute T1}}

Click below to when prompted to confirm installation.

`y`{{execute T1}}

### Personalize Your Environment

Now, open `personalize.sh`{{open}}, and **set your username and login secret**
on lines 1 and 2. Your personalized lab environment has been
pre-provisioned with a Resource Group, an HCS Datacenter, an
AKS Cluster, and a VNet. This script will login you into your
personal Azure sandbox, and set several environment variables
that enable parameterized scripts later in the lab to ensure you are
interracting with your own sandboxed environment.

Click below to run the script.

`sudo bash personalize.sh`{{execute T1}}

Example Output:

```shell-session
export RESOURCE_GROUP=dwcc-username-rg
[
  {
    "cloudName": "AzureCloud",
...TRUNCATED
]
Command group 'hcs' is in preview. It may be changed/removed in a future release.
export AKS_CLUSTER=dwcc-username-aks
export HCS_MANAGED_APP=dwcc-username-managed-hcs
```

### Validate Environment

Now, review your `.bashrc`{{open}} file to see
the values set by that script.

Source the updated `.bashrc` and make sure the
environment variables are available to your shell.

`source $HOME/.bashrc`{{execute T1}}

Now, review all the resources in your environment.

`az resource list --resource-group $RESOURCE_GROUP | jq -r '.[] | .name'`{{execute T1}}

Example output:

```shell-session
dwcc-username--aks
dwcc-username-vnet
dwcc-username-managed-hcs
```
