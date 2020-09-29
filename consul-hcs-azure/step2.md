### Enable Peering

Enable VNet Peering between HCS and the AKS Cluster.

`bash peering.sh`{{execute T1}}

Now, your environment looks like this.

![VNet Peering](./assets/img/vnet_peering.png)

### Create the Kubernetes Secrets

Next, configure the necessary secrets to enable communication
between the HCS cluster and the AKS cluster.

First, start by bootstrapping Consul ACLs and storing the token
as a Kubernetes secret.

`az hcs create-token --name $HCS_MANAGED_APP --resource-group $RESOURCE_GROUP --output-kubernetes-secret | kubectl apply -f -`{{execute T1}}

Example output:

```plaintext
secret/dwcc-username-managed-hcs-bootstrap-token created
```

Next, generate a Kubernetes secret with credentials for the HCS cluster.

`az hcs generate-kubernetes-secret --name $HCS_MANAGED_APP --resource-group $RESOURCE_GROUP | kubectl apply -f -`{{execute T1}}

Example output:

```plaintext
secret/dwcc-username-managed-hcs created
```
