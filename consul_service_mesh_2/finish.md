# Review

Congratulations! You have now successfully deployed two services into Consul's service mesh running on a Kubernetes cluster. The two services are using Consul to discover each other and to communicate over mTLS with sidecar proxies. This is the first step in deploying an application into a zero-trust network.

Specifically you:

- Reviewed a service configuration file
- Deployed a backend service
- Verified the backend service deployment by with kubectl
- Viewed the backend service and its sidecar in the Consul Web UI
- Learned how to configure an upstream service using configuration annotations
- Deployed the frontend service
- Verified the frontend service deployment by with kubectl
- Viewed the frontend service and its sidecar in the Consul Web UI
- Configured port forwarding for your frontend service
- Viewed the frontend from a web browser

# Next Steps

To learn more about Consul service mesh, [Understand Consul Service Mesh](https://learn.hashicorp.com/consul/gs-consul-service-mesh/understand-consul-service-mesh) provides a reference guide for the Consul service mesh based labs.
