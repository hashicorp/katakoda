# Consul Service Mesh on Kubernetes

In this lab you will perform all the steps needed to deploy Consul service mesh as the data plane for your Kubernetes cluster.

The lab uses Minikube to deploy the cluster but the commands can be applied to any Kubernetes flavor.

If you are already familiar with the basics of Consul, [Understand Consul Service Mesh](https://learn.hashicorp.com/consul/gs-consul-service-mesh/understand-consul-service-mesh) provides a reference guide for the Consul service mesh based labs.

During this session you will deploy a Consul datacenter using Minikube and Helm 3.x. Specifically you will:

- Create a local Kubernetes cluster using Minikube
- Check the state of your Kubernetes cluster
- Add the official HashiCorp Consul Helm chart repo
- Review a Consul service mesh configuration file
- Deploy Consul to Kubernetes using the HashiCorp Consul Helm chart
- Verify the Consul deployment
- Configure port forwarding for the Consul UI

