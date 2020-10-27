The Consul service mesh in this lab is configured to have a pre-configured policy that denies all services communication.

You can check the initial intentions configuration on Consul UI intentions tab:

[Open Consul UI intentions tab](https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/ui/dc1/intentions)

You should get a configuration similar to one in the following picture:

![intentions](consul-ui-intentions-deny-all-active.png)

### Verify service connectivity

To prove the services are not able to communicate you can connect to the `web` service running on one of the client agents.

[Open Web frontend UI from inside the node](https://[[HOST_SUBDOMAIN]]-9002-[[KATACODA_HOST]].environments.katacoda.com/ui)

![frontend fail](web-service-ui-fail.png)