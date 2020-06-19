

This hands-on lab comes with a prepared configuration for the `web` service.

`cat web.yml | more`{{execute}}

In addition to the `"consul.hashicorp.com/connect-inject": "true"` annotation, the
`web` service defines the `"consul.hashicorp.com/connect-service-upstreams"` annotation. This annotation explicitly declares the upstream for the web service, which is the `api` service you deployed previously. Notice the annotation also contains a ":dc1" segment that indicates which datacenter handles requests for the service.

#### Deploy app with kubectl

First, make sure you set the right context for `kubectl`.

`export KUBECONFIG=${HOME}/.shipyard/config/dc2/kubeconfig.yaml`{{execute}}

Once the context is set, you can deploy the `web` application using `kubectl`.

`kubectl apply -f ~/web.yml`{{execute}}

#### Check the service is running in Kubernetes

Finally, you can verify the `web` service is deployed successfully.

`kubectl get pods`{{execute}}

Wait until the pod is marked as `Running` to continue. This might take up to a minute to complete

### Verify application status in Consul UI

Open [Consul UI](https://[[HOST_SUBDOMAIN]]-8502-[[KATACODA_HOST]].environments.katacoda.com/ui/dc2/services) and ensure the service `web` is registered and healthy in Consul.
