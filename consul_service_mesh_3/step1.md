#### Check Consul is up and running

Open [Consul UI](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/ui/minidc/services) and ensure four services `api`, `api-sidecar-proxy`, `web` and `web-sidecar-proxy` are registered and healthy in Consul.

Open the [Dashboard](https://[[HOST_SUBDOMAIN]]-9090-[[KATACODA_HOST]].environments.katacoda.com/ui) tab to be redirected to the web application UI.

### Connect to Consul container

`kubectl exec -it hashicorp-consul-server-0 /bin/sh`{{execute}}