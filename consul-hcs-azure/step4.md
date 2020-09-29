### Create Helm configuration

Next, generate the helm configuration file that you will apply to your AKS cluster.

`az hcs generate-helm-values --name $HCS_MANAGED_APP --resource-group $RESOURCE_GROUP --aks-cluster-name $AKS_CLUSTER > config.yaml`{{execute T1}}

Now, open `config.yaml`{{open}} and review it's contents.

Click below to uncomment line 29 so that gossip ports are exposed.

`sed -i -e 's/^  # \(exposeGossipPorts\)/  \1/' config.yaml`{{execute T1}}

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

Now that your clients have been deployed, your environment looks
like this:

![Consul Clients](./assets/consul_clients.png)