
In this hands-on lab you are going to use Helm to deploy Consul using the official HashiCorp Consul Helm chart.

Add the HashiCorp repository to Helm:

`helm repo add hashicorp https://helm.releases.hashicorp.com`{{execute}}

### Review configuration for Consul datacenter

This hands-on lab comes with a prepared configuration.

`cat dc1-values.yml | more`{{execute}}

Note the following settings:

* The server key contains parameters related to the server pods. The chart is configured to create one Consul server per Kubernetes node.
* The Consul service mesh is enabled by setting the connectInject key to true. When the service mesh connect injector is installed, then a sidecar proxy is automatically added to all pods.
* The ui section enables Consul web UI.
* The meshGateway section defines the deploy of a Consul mesh gateway that will be used for the communications to and from the secondary datacenter you will deploy later in this lab.

### Deploy primary datacenter (`dc1`)

Make sure your kubectl is configured to point to the right Kubernetes cluster:

`export KUBECONFIG=${HOME}/.shipyard/config/dc1/kubeconfig.yaml`{{execute}}

You will use `helm install` to deploy Consul using the configuration defined in `dc1-values.yml`. This should only take a few minutes.

`helm install -f ./dc1-values.yml consul hashicorp/consul --version "0.22.0" --timeout 10m`{{execute}}

#### Verify the Consul deployment

Execute `kubectl get services` from the command line to verify the services, including Consul, are running in the Kubernetes cluster.

`kubectl get services`{{execute}}

In the output you should have a service named `consul-mesh-gateway`

```
NAME                TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)       AGE
...
consul-mesh-gateway NodePort    10.43.132.201   <none>        443:30001/TCP 2m
...
```

Before moving to the next step check the deployment status using:

`kubectl get pods --all-namespaces`{{execute}}

and verifying that all pods are in the `Running` state and ready.

```
NAME                                                          READY   STATUS    RESTARTS   AGE
consul-connect-injector-webhook-deployment-546d67b476-rnj8k   1/1     Running   0          71s
consul-server-0                                               1/1     Running   0          69s
consul-2rkgj                                                  1/1     Running   0          69s
consul-mesh-gateway-b95f65ff7-cmjkd                           2/2     Running   0          71s
```