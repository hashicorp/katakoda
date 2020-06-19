To test the Consul service mesh you will deploy two simple services, `api` and `web`. The two services represent a simple two-tier application made of a backend api service and a frontend that communicates with the api service over HTTP and exposes the results in a web ui.

#### Review the backend service configuration

This hands-on lab comes with a prepared configuration for the `api` service.

`api.yml`{{open}}

The `"consul.hashicorp.com/connect-inject": "true"` annotation in the configuration ensures a sidecar proxy is automatically added to the `api` pod. This proxy will handle inbound and outbound service connections, automatically wrapping and verifying TLS connections.

#### Deploy the service with kubectl

You can deploy the `api` service using `kubectl`.

`kubectl apply -f ~/api.yml`{{execute}}

#### Check the service is running in Kubernetes

Finally, you can verify the `api` service is deployed successfully.

`kubectl get pods`{{execute}}

Wait until the pod is marked as `Running` to continue. This might take up to a minute to complete.

### Verify application status in Consul UI

Open [Consul UI](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/ui) and ensure the services `api` is registered and healthy in Consul.

<div style="background-color:#eff5ff; color:#416f8c; border:1px solid #d0e0ff; padding:1em; border-radius:3px; margin:24px 0;">
  <p><strong>Info: </strong>
  
  In Consul 1.8.x a service deployed correctly into the service mesh will have "connected with proxy" in its description. Prior versions of Consul will have an additional service named "service_name-sidecar-proxy".

</p></div>
