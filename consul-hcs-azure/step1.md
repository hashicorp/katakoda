### Install the HCS on Azure extension

Click below to install the HCS on Azure extension for the Azure CLI.
This extension is required to manage HCS on Azure from the command line.

`az extension add --source https://releases.hashicorp.com/hcs/0.3.0/hcs-0.3.0-py2.py3-none-any.whl`{{execute T1}}

Click below to when prompted to confirm installation.

`y`{{execute T1}}

### Personalize Your Environment

Now, open `personalize`{{open}}, and **set your username and login secret**
on lines 1 and 2. The following diagram illustrates
the starting state of your environment

![Personal Sandbox](./assets/starting_point.png)

The script will login you into your
personal Azure sandbox, and set environment variables
required to ensure you are interracting with your own
sandboxed environment.

`bash personalize.sh`{{execute T1}}

Example Output:

```shell-session
export RESOURCE_GROUP=dwcc-username-rg
[
  {
    "cloudName": "AzureCloud",
...TRUNCATED
export HCS_MANAGED_APP=dwcc-username-managed-hcs
```

### Validate Environment

Source the updated `.bashrc`.

`source $HOME/.bashrc`{{execute T1}}

Review all the resources in your environment.

`az resource list --resource-group $RESOURCE_GROUP | jq -r '.[] | .name'`{{execute T1}}

Example output:

```shell-session
dwcc-username--aks
dwcc-username-vnet
dwcc-username-managed-hcs
```

Verify you can connect to AKS by issuing the following command.

`kubectl get pods -n kube-system`{{execute T1}}
