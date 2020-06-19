#### Check Consul is up and running

Open [Consul UI](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/ui) and ensure services `web` and `api` are registered and healthy in Consul.

<div style="background-color:#eff5ff; color:#416f8c; border:1px solid #d0e0ff; padding:1em; border-radius:3px; margin:24px 0;">
  <p><strong>Info: </strong>
  
    In Consul 1.8 a service deployed correctly into the service mesh will have "connected with proxy" in its description. Prior versions of Consul will have an additional service named "service_name-sidecar-proxy".

</p></div>

Open the [Dashboard](https://[[HOST_SUBDOMAIN]]-9090-[[KATACODA_HOST]].environments.katacoda.com/ui) tab to be redirected to the web application UI.

### Connect to Consul container

To create a zero-trust network you will need to manage Consul intentions, which allow or deny service communication. The first step is to connect to the Kubernetes container with the Consul server.

`kubectl exec -it hashicorp-consul-server-0 /bin/sh`{{execute}}


<div style="background-color:#eff5ff; color:#416f8c; border:1px solid #d0e0ff; padding:1em; border-radius:3px; margin:24px 0;">
  <p><strong>Info:</strong>
  
  Consul intentions can also be managed using the UI or the API interface.

</p></div>
