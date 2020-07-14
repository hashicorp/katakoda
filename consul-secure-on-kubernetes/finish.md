In this hands-on lab you learned how to secure a Consul service mesh running in Kubernetes.
This hands-on lab introduced you to the three core components of Consul
service mesh security, and how they can be configured using the [Consul Helm chart](https://www.consul.io/docs/k8s/helm).

The three core components of Consul service mesh security are:

- [Gossip Encryption](https://learn.hashicorp.com/consul/security-networking/agent-encryption),
- [RPC encryption with TLS](https://learn.hashicorp.com/consul/security-networking/certificates)
- [Access Controls Lists or ACLs](https://learn.hashicorp.com/consul/security-networking/production-acls).

Specifically you:

- Installed Consul service mesh in a Kubernetes cluster
- Verified that gossip traffic occurs in clear text
- Verified that RPC traffic occurs in clear text and ACLs are not enabled
- Enabled gossip encryption, TLS, and ACLs
- Set necessary TLS configuration
- Retrieved and set an ACL token
- Verified that ACL tokens were now required

For more guidance on how to use Consul visit us on the [HashiCorp Learn Platform](https://learn.hashicorp.com/consul).