# Deploy services to Consul service mesh on Kubernetes

In this lab you will deploy two services, web and api, into Consul's service mesh running on a Kubernetes cluster. The two services will use Consul to discover each other and communicate over mTLS with sidecar proxies. This is the first step in deploying an application into a zero-trust network.

The lab uses Minikube to deploy the cluster but the commands can be applied to any Kubernetes flavor.

If you are already familiar with the basics of Consul, [understand Consul service mesh](https://learn.hashicorp.com/consul/gs-consul-service-mesh/understand-consul-service-mesh) provides a reference guide for the Consul service mesh based labs.

In this hands-on lab, you will deploy two services in the Consul service mesh. Specifically you will:

- Review a service configuration file
- Deploy a backend service
- Verify the backend service deployment by with kubectl
- View the backend service and its sidecar in the Consul Web UI
- Learn how to configure an upstream service using configuration annotations
- Deploy the frontend service
- Verify the frontend service deployment by with kubectl
- View the frontend service and its sidecar in the Consul Web UI
- Configure port forwarding for your frontend service
- View the frontend from a web browser

