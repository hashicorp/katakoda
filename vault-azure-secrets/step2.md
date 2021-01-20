The Azure secrets engine requires the credentials you generated in the
[Create an Azure Service Principal] step to communicate with Azure and generate
service principals.

Create variables to store your Azure credentials.

> Replace the placeholder values defined on each line with the credential requested.

```shell
read -d "\n" SUBSCRIPTION_ID CLIENT_ID CLIENT_SECRET TENANT_ID <<<$(echo "
<Subscription_id>
<Client_id>
<Client_secret>
<Tenant_id>
")
```{{execute}}

Display the variables.

```shell
echo "
Subscription ID = $SUBSCRIPTION_ID
Client ID = $CLIENT_ID
Client Secret = $CLIENT_SECRET
Tenant ID = $TENANT_ID
"
```{{execute}}

Configure the Azure secrets engine with the Azure credentials.

```shell
vault write azure/config \
        subscription_id=$SUBSCRIPTION_ID  \
        client_id=$CLIENT_ID \
        client_secret=$CLIENT_SECRET \
        tenant_id=$TENANT_ID
```{{execute}}
