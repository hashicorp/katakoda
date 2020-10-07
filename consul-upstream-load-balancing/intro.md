# Load balancing in Consul service mesh with Envoy

In this hands-on lab, you will operate a Consul datacenter, deployed using Docker, to configure load balancing policies on Envoy sidecar proxies.

Specifically, you will:
- Inspect the environment
- Verify default _random_ load balancing policy
- Use centralized configuration to set service defaults
- Use _maglev_ policy to configure sticky session for load balancing
- Verify the new configuration
- Use *least_request* load balancing policy
- Verify the new configuration
- Use the ingress gateway to access the service

The environment provides you with a Consul service mesh with one server agent node, three client agent nodes to run the services, and one ingress gateway node to allow external requests inside your service mesh. 

To learn how to deploy a Consul service mesh using Envoy as data plane, review the [Secure Service Communication with Consul Service Mesh and Envoy](/tutorials/consul/service-mesh-with-envoy-proxy) tutorial.

To learn more on ingress gateways, review the [Allow External Traffic Inside Your Service Mesh With Ingress Gateways](/tutorials/consul/service-mesh-ingress-gateways) tutorial. 
