Next you are going to deploy the frontend service.

This hands-on lab comes with a prepared configuration.

`web.yml`{{open}}

In additon to the `"consul.hashicorp.com/connect-inject": "true"` annotation, the
`web` service defines the `"consul.hashicorp.com/connect-service-upstreams"` annotation. This annotation  explicitly declares the upstream for the web service, which is the `api` service you deployed previously.

#### Deploy app with kubectl

You can deploy the `web` application using `kubectl`.

`kubectl apply -f ~/web.yml`{{execute}}

#### Check the service is running in Kubernetes

Finally, you can verify the `web` service is deployed successfully.

`kubectl get pods`{{execute}}

Wait until the pod is marked as `Running` to continue. This might take up to a minute to complete

### Verify application status in Consul UI

Open [Consul UI](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/ui) and ensure the service `web` is registered and healthy in Consul.

<div style="background-color:#eff5ff; color:#416f8c; border:1px solid #d0e0ff; padding:1em; border-radius:3px; margin:24px 0;">
  <p><strong>Info: </strong>
  
  In Consul 1.8.x a service deployed correctly into the service mesh will have "connected with proxy" in its description. Prior versions of Consul will have an additional service named "service_name-sidecar-proxy".

</p></div>
