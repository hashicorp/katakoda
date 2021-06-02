## Review

In this hands-on lab, you deployed a secure Consul datacenter using
Vault to generate and manage ACL tokens.

The lab guided you through the steps necessary to deploy Consul
with ACL enabled to verify identity of your server nodes and assign them 
necessary permissions.

Specifically, you:
- Created a management token for Vault
- Enabled Consul secrets engine in Vault
- Created a Consul policy for servers
- Created a Vault role to map Consul policy
- Created a Vault token associated with the role
- Verified the token was present in Consul and applied it to the agents

## Next Steps

If you are already familiar with the basics of Consul, but are not familiar with Consul ACL system encryption review the
[Secure Consul with ACLs](https://learn.hashicorp.com/consul/security-networking/production-acls) tutorial and learn how to enable and use ACLs on your Consul datacenter.
