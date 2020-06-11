# Configure a zero-trust network with Consul service mesh intentions on Kubernetes

In this hands-on lab, you will configure zero-trust networking with Consul service intentions on Kubernetes.

The lab uses Minikube to deploy the cluster but the commands can be applied to any Kubernetes flavor.

In this hands-on lab you will:

- Start a remote interactive terminal on a running Consul container
- Configure a default-deny intention for your service mesh
- Verify the intention from the Consul web UI
- Vefify the intention from the command line
- Configure an allow intention for your frontend -> backend services
- Verify the intention from the frontend UI
- Verify the intention from the Consul web UI

If you are already familiar with the basics of Consul, [understand Consul service mesh](https://learn.hashicorp.com/consul/gs-consul-service-mesh/understand-consul-service-mesh) provides a reference guide for the Consul service mesh based scenarios.

