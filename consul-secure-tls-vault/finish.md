## Review

In this hands-on lab, you deployed a secure Consul datacenter using Vault to generate and manage certificates.

The lab guided you through the steps necessary to deploy Consul with TLS encryption enabled to authorize access to the UI, API, CLI, services, and agents.

Specifically, you:

- Started a Vault dev instance
- Created a policy in Vault to allow certificate generation
- Enabled the PKI secrets engine in Vault
- Initialized the CA and generate an intermediate certificate
- Generated certificates for your Consul servers
- Used consul-template to retrieve certificates at runtime
- Performed a certificate rotation

## Next Steps

Now that you have tested TLS encryption in this interactive environment, use the (https://learn.hashicorp.com/tutorials/consul/tls-encryption-secure) tutorial to configure TLS encryption in your Consul datacenter. 
