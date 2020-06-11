#### Check Consul is up and running

Open [Consul UI](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/ui/minidc/services) and ensure four services are registered and healthy in Consul 
* `api` 
* `api-sidecar-proxy`
* `web`
* `web-sidecar-proxy` 

Open the [Dashboard](https://[[HOST_SUBDOMAIN]]-9090-[[KATACODA_HOST]].environments.katacoda.com/ui) tab to be redirected to the web application UI.

### Connect to Consul container

To create a zero-trust network you will need to manage Consul intentions, which allow or deny service communication. The first step is to connect to the Kubernetes container with the Consul server. 
`kubectl exec -it hashicorp-consul-server-0 /bin/sh`{{execute}}
