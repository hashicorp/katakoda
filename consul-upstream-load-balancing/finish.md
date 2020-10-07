## Review

In this hands-on lab, you will operated a Consul datacenter, deployed using Docker, to configure load balancing policies on Envoy sidecar proxies.

Specifically, you:
- Inspected the environment
- Verified the default _random_ load balancing policy
- Used centralized configuration to set service defaults
- Used _maglev_ policy to configure sticky session for load balancing
- Verified the new configuration
- Uses the *least_request* load balancing policy
- Verified the new configuration
- Used the ingress gateway to access the service

The environment for this lab was provided with a Consul service mesh with one server agent node, three client agent nodes to run the services, and one ingress gateway node to allow external requests inside your service mesh. 

To learn how to deploy a Consul service mesh using Envoy as data plane, review the [Secure Service Communication with Consul Service Mesh and Envoy](/tutorials/consul/service-mesh-with-envoy-proxy) tutorial.

To learn more on ingress gateways, review the [Allow External Traffic Inside Your Service Mesh With Ingress Gateways](/tutorials/consul/service-mesh-ingress-gateways) tutorial. 
