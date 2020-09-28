# Configure peering from HCS on Azure to AKS
az network vnet peering create \
  -g dwcc-$UNAME-hcs-managed-rg \
  -n hcs-to-aks \
  --vnet-name $(az network vnet list \
    --resource-group dwcc-$UNAME-hcs-managed-rg | jq -r '.[0].name') \
  --remote-vnet $(az network vnet list \
    --resource-group $RESOURCE_GROUP | jq -r '.[0].id') \
  --allow-vnet-access

# Configure peering from AKS to HCS on Azure
az network vnet peering create \
  -g $RESOURCE_GROUP \
  -n aks-to-hcs \
  --vnet-name $(az network vnet list \
    --resource-group $RESOURCE_GROUP | jq -r '.[0].name') \
  --remote-vnet $(az network vnet list \
    --resource-group dwcc-$UNAME-hcs-managed-rg | jq -r '.[0].id') \
  --allow-vnet-access