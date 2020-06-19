# Federate Consul Between Kubernetes Clusters

In this lab you will perform all the steps needed to deploy two Consul datacenters in two different Kubernetes clusters and federate them using mesh gateways.

The lab uses Shipyard to deploy the clusters but the commands can be applied to any Kubernetes flavor.

If you are already familiar with the basics of Consul, [Federation Between Kubernetes Clusters](https://www.consul.io/docs/k8s/installation/multi-cluster/kubernetes) provides a reference guide for the steps performed in this lab.

During this session you will deploy two Consul datacenters using Shipyard and Helm 3.x. Specifically you will:

- Add the official HashiCorp Consul Helm chart repo
- Review the Consul service mesh configuration file for your primary datacenter
- Deploy Consul to a primary Kubernetes cluster using the HashiCorp Consul Helm chart
- Verify the Consul deployment
- Enable automatic WAN federation between the two Consul datacenters using Kubernetes secrets
- Review the Consul service mesh configuration file for your secondary datacenter
- Deploy Consul to a secondary Kubernetes cluster using the HashiCorp Consul Helm chart
- Verify federation between the two Consul datacenters
- Review a service configuration file
- Deploy a backend service
- Verify the backend service deployment by with kubectl
- View the backend service in the Consul Web UI
- Learn how to configure an upstream service using configuration annotations
- Deploy the frontend service
- Verify the frontend service deployment by with kubectl
- View the frontend service in the Consul Web UI
- View the frontend service from a web browser
