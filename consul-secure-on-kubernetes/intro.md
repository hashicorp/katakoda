In this hands-on lab, you will deploy and secure a Consul service mesh running in Kubernetes.
This hands-on lab is designed to introduce you to the four core components of Consul
service mesh security, and how they can be configured using the [Consul Helm chart](https://www.consul.io/docs/k8s/helm).

The four core components of Consul service mesh security are:

- [Gossip Encryption](https://learn.hashicorp.com/consul/security-networking/agent-encryption)
- [RPC encryption with TLS](https://learn.hashicorp.com/consul/security-networking/certificates)
- [Access Controls Lists or ACLs](https://learn.hashicorp.com/consul/security-networking/production-acls)
- [Intentions](https://learn.hashicorp.com/consul/gs-consul-service-mesh/network-security-with-consul-service-mesh)

This hands-on lab will guide you through enabling all four using the Consul Helm chart and the Consul CLI.

Specifically, you will:

- Install Consul service mesh in a Kubernetes cluster
- Verify that gossip traffic occurs in clear text
- Verify that RPC traffic occurs in clear text and ACLs are not enabled
- Enable gossip encryption, TLS, and ACLs
- Set TLS configuration
- Retrieve and set an ACL token
- Verify that network traffic is now encrypted
- Secure inter-service traffic using Consul intentions
