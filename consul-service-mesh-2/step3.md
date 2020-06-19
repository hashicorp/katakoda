To access a service running inside a Kubernetes cluster you will have to expose the service to an external network.

#### Configure port forwarding for your frontend service

To access the app running inside your Consul service mesh, you will setup port forwarding.

`export IP_ADDR=$(hostname -I | awk '{print $1}')`{{execute}}

`kubectl port-forward service/web 9090:9090 --address ${IP_ADDR}`{{execute}}

This will forward port `9090` from `service/web` at port `9090` to your test machine.

You can now open the [Dashboard](https://[[HOST_SUBDOMAIN]]-9090-[[KATACODA_HOST]].environments.katacoda.com/ui) tab to be redirected to the web application UI.
