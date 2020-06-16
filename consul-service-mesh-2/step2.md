#### Deploy frontend service in your service mesh

This hands-on lab comes with a prepared configuration.

`web.yml`{{open}}

In additon to the `"consul.hashicorp.com/connect-inject": "true"` annotation, the
`web` service defines the `"consul.hashicorp.com/connect-service-upstreams"` annotation. This annotation
 explicitly declares the upstream for the web service, which is the `api` service you deployed
 previously.

#### Deploy app with kubectl

You can deploy the `web` application using `kubectl`.

`kubectl apply -f ~/web.yml`{{execute}}

#### Check the service is running in Kubernetes

Finally, you can verify the `web` service is deployed successfully.

`kubectl get pods`{{execute}}

Wait until the pod is marked as `Running` to continue. This might take up to a minute to complete

### Verify application status in Consul UI

Open [Consul UI](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/ui/minidc/services) and ensure two services `api` and `api-sidecar-proxy` are registered and healthy in Consul.
