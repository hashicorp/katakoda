## Review

In this hands-on lab, you deployed a secure Consul datacenter using Vault to generate and manage certificates.

The lab will guided you through the steps necessary to deploy Consul with TLS encryption enabled to secure access to the UI, API, CLI, services, and agents.

Specifically, you:

- Started a Vault dev instance
- Created a policy in Vault to allow certificate generation
- Enabled the PKI engine in Vault
- Initialized the CA and generate an intermediate certificate
- Generated certificates for your Consul servers
- Used consul-template to retrieve certificates at runtime
- Performed a certificate rotation

## Next Steps

If you are already familiar with the basics of Consul, [Secure Consul with ACLs](https://learn.hashicorp.com/consul/security-networking/production-acls) provides a reference guide for the steps required to enable and use ACLs on your Consul datacenter.
