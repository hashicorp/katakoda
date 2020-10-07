
The load balancing policy for the datacenter applies also to the service resolution performed by ingress gateways. So, once you configured the policies for the services and tested it internally using the client service, you can introduce an ingress gateway in your configuration and the same policies will be now respected by external requests being served by your Consul datacenter.

<!--Arch diagram-->
![Consul service mesh load balancing with ingress gateway](./assets/consul-lb-envoy-ingress-gw.png)

In this lab you can access the service from your browser using the [ingress gateway](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/).

By refreshing the page in your web browser you can verify that the request is being balanced between both instances of the service.