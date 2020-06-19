To verify the two datacenter are actively working and routing traffic through the mesh gateways you will use two services, `api` and `web`.

The two services represent a simple two-tier application made of a backend api service and a frontend that communicates with the api service over HTTP and exposes the results in a web ui.

#### Review the backend service configuration

This hands-on lab comes with a prepared configuration for the `api` service.

`cat api.yml | more`{{execute}}

The `"consul.hashicorp.com/connect-inject": "true"` annotation in the configuration ensures a sidecar proxy is automatically added to the `api` pod. This proxy will handle inbound and outbound service connections, automatically wrapping and verifying TLS connections.

#### Deploy the service with kubectl

First, make sure you set the right context for `kubectl`.

`export KUBECONFIG=${HOME}/.shipyard/config/dc1/kubeconfig.yaml`{{execute}}

Once the context is set, you can deploy the `api` service using `kubectl`.

`kubectl apply -f ~/api.yml`{{execute}}

#### Check the service is running in Kubernetes

Finally, you can verify the `api` service is deployed successfully.

`kubectl get pods`{{execute}}

Wait until the pod is marked as `Running` to continue. This might take up to a minute to complete.

### Verify application status in Consul UI

Open [Consul UI](https://[[HOST_SUBDOMAIN]]-8501-[[KATACODA_HOST]].environments.katacoda.com/ui/dc1/services) and ensure service `api` is registered and healthy in Consul.






