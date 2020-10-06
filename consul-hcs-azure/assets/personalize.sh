export UNAME=<your-user-name>
export SECRET=<your-secret>
export TENANT_ID=<your-tenant-id>


export RESOURCE_GROUP=dwcc-$UNAME-rg

sudo tee -a $HOME/.bashrc <<EOF
export UNAME=$UNAME
export RESOURCE_GROUP=$RESOURCE_GROUP
EOF

az login --service-principal --username $SECRET --password hashiconf --tenant $TENANT_ID

export AKS_CLUSTER=$(az aks list --resource-group $RESOURCE_GROUP | jq -r '.[] | .name')
export HCS_MANAGED_APP=$(az hcs list --resource-group $RESOURCE_GROUP | jq -r '.[] | .name')

sudo tee -a ~/.bashrc <<EOF
export AKS_CLUSTER=$AKS_CLUSTER
export HCS_MANAGED_APP=$HCS_MANAGED_APP
EOF

az aks get-credentials --name $AKS_CLUSTER --resource-group $RESOURCE_GROUP
