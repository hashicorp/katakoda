export UNAME=derek-s
export SECRET=<your-secret>
export RESOURCE_GROUP=dwcc-$UNAME-rg

sudo tee -a $HOME/.bashrc <<EOF
export RESOURCE_GROUP=$RESOURCE_GROUP
EOF

az login --service-principal --username $SECRET --password hashiconf --tenant 0e3e2e88-8caf-41ca-b4da-e3b33b6c52ec

export AKS_CLUSTER=$(az aks list --resource-group $RESOURCE_GROUP | jq -r '.[] | .name')
export HCS_MANAGED_APP=$(az hcs list --resource-group $RESOURCE_GROUP | jq -r '.[] | .name')

sudo tee -a ~/.bashrc <<EOF
export AKS_CLUSTER=$AKS_CLUSTER
export HCS_MANAGED_APP=$HCS_MANAGED_APP
EOF
