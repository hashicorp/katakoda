## Review

In this hands-on lab, you operated a Consul datacenter that was deployed using Docker and configured load balancing policies on the service sidecar proxies.

Specifically, you:
- Inspected the environment with the Consul CLI
- Verified the default *round_robin* load balancing policy
- Used centralized configuration to set service defaults
- Used the _maglev_ policy to configure load balancing with sticky session
- Verified the new configuration
- Used the *least_request* load balancing policy
- Verified the new configuration
- Used the ingress gateway to access the service

The environment for this lab was provided with a Consul service mesh with one server agent node, three client agent nodes to run the services, and one ingress gateway node to allow external requests inside your service mesh. 

To learn how to deploy a Consul service mesh using Envoy as data plane, review the [Secure Service Communication with Consul Service Mesh and Envoy](/tutorials/consul/service-mesh-with-envoy-proxy) tutorial.

To learn more on ingress gateways, review the [Allow External Traffic Inside Your Service Mesh With Ingress Gateways](/tutorials/consul/service-mesh-ingress-gateways) tutorial. 
