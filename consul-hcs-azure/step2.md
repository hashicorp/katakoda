### Enable Peering

You will need to enable VNet Peering between the VNet in the
primary Resource Group and the VNet in the HCS Managed Resource
Group.

Click below to establish VNet peering.

`./peering.sh`{{execute T1}}

Now, your environment looks like this. The dotted
lines indicated the VNet peering.

![VNet Peering](./assets/vnet_peering.png)

### Configure access to AKS

Next, export the Azure AKS KUBECONFIG settings to the development host.

`az aks get-credentials --name $AKS_CLUSTER --resource-group $RESOURCE_GROUP`{{execute T1}}

Example output:

```plaintext
Merged "dwcc-username-aks" as current context in /root/.kube/config
```

Verify the configuration by issuing the following command.

`kubectl get pods -n kube-system`{{execute T1}}

```plaintext
azure-cni-networkmonitor-8h9h8       1/1     Running   0          16h
azure-ip-masq-agent-xjkhf            1/1     Running   0          16h
coredns-869cb84759-4hwpj             1/1     Running   0          16h
coredns-869cb84759-l8f7t             1/1     Running   0          16h
coredns-autoscaler-5b867494f-5hphv   1/1     Running   0          16h
kube-proxy-8csmn                     1/1     Running   0          16h
metrics-server-6cd7558856-fzvz2      1/1     Running   0          16h
tunnelfront-76454d856b-hpcwb         2/2     Running   0          16h
```
