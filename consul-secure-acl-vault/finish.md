## Review

In this hands-on lab, you deployed a secure Consul datacenter using
Vault to generate and manage ACL tokens.

The lab guided you through the steps necessary to deploy Consul
with ACL enabled to verify identity of your server nodes and assign them necessary permissions.

Specifically, you:
- Started a Vault dev instance
- Started a Consul datacenter with ACLs enabled
- Bootstrapped ACLs in Consul
- Created a Consul policy for servers
- Enabled the Consul secrets engine in Vault
- Created a management token for Vault
- Created a Vault role to map to a Consul policy
- Created a Vault token associated with the role
- Verified the token was present in Consul and applied it to the agent

## Next Steps

Now that you've bootstrapped the ACLs system in an interactive environment, use the
[Secure Consul with ACLs](https://learn.hashicorp.com/consul/security-networking/production-acls) tutorial to enable and use ACLs on your Consul datacenter.
