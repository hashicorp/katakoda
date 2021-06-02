# Secure Consul Agent Communication with ACL

In this hands-on lab, you will deploy a secure Consul
datacenter using Vault to generate and manage ACL tokens.

The lab will guide you through the steps necessary to configure Consul secrets
engine in your Vault instance, and use it to generate ACL tokens to secure 
access to the datacenter data and define agents' permissions.

Specifically, you will:
- Create a management token for Vault
- Enable Consul secrets engine in Vault
- Create a Consul policy for servers
- Create a Vault role to map Consul policy
- Create a Vault token associated with the role
- Verify the token was present in Consul and apply it to the agents

If you are already familiar with the basics of Consul, but are not familiar 
with Consul ACL system review the 
[Secure Consul with ACLs](https://learn.hashicorp.com/consul/security-networking/production-acls) 
tutorial and learn how to enable and use ACLs on your Consul datacenter.
