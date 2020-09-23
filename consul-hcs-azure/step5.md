Now, setup virtual network peering between the HCS Datacenter's
vnet and the AKS Cluster's vnet.

### Configure peering from HCS on Azure to AKS

First, create a peering from the HCS Datacenter's vnet to the AKS Cluster's vnet.

`az network vnet peering create \
  -g dwcc-$USERNAME-hcs-managed-rg \
  -n hcs-to-aks \
  --vnet-name $(az network vnet list \
    --resource-group dwcc-$USERNAME-hcs-managed-rg | jq -r '.[0].name') \
  --remote-vnet $(az network vnet list \
    --resource-group dwcc-$USERNAME-rg | jq -r '.[0].id') \
  --allow-vnet-access`{{execute T1}}

### Configure peering from AKS to HCS on Azure

Next, create a peering from the AKS Cluster's vnet to the HCS Datacenter's vnet.

`az network vnet peering create \
  -g dwcc-$USERNAME-rg \
  -n aks-to-hcs \
  --vnet-name $(az network vnet list \
    --resource-group dwcc-$USERNAME-rg | jq -r '.[0].name') \
  --remote-vnet $(az network vnet list \
    --resource-group dwcc-$USERNAME-hcs-managed-rg | jq -r '.[0].id') \
  --allow-vnet-access`{{execute T1}}

### Deploy Consul clients 

Now, deploy Consul to the the AKS cluster using the `config.yaml` file you generated.

`helm install hcs hashicorp/consul -f config.yaml --wait`{{execute T1}}

Abbreviated example output:

```plaintext
NAME: hcs
LAST DEPLOYED: Tue Sep  1 13:31:29 2020
NAMESPACE: default
...OMITTED
  $ helm status hcs
  $ helm get all hcs
```

Next, check that Consul is deployed and running.

`watch kubectl get pods`{{execute T1}}

The deployment is complete when all pods are Ready with a
status of `Running`.

```plaintext
NAME                                         READY   STATUS    RESTARTS   AGE
consul-5nmmx                                 1/1     Running   0          2m3s
consul-connect-injector-webhook-deployment   1/1     Running   0          2m3s
```

### Deploy the HashiCups Application

Now, deploy a demo production workload to the AKS cluster.

`kubectl apply -f hashicups/ --wait`{{execute interrupt T1}}

Example output:

```plaintext
service/frontend created
serviceaccount/frontend created
configmap/nginx-configmap created
deployment.apps/frontend created
...TRUNCATED
```

Next, check that the workload is deployed and running.

`watch kubectl get pods`{{execute T1}}

The deployment is complete when all pods are Ready with a
status of `Running`.

Example output:

```plaintext
NAME                                         READY   STATUS    RESTARTS   AGE
consul-5nmmx                                 1/1     Running   0          6m4s
consul-connect-injector-webhook-deployment   1/1     Running   0          6m4s
frontend                                     3/3     Running   0          2m5s
postgres                                     3/3     Running   0          2m4s
products-api                                 3/3     Running   0          2m5s
public-api                                   3/3     Running   0          2m4s
```

