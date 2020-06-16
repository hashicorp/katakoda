## Review

In this hands-on lab, you deployed a secure Consul datacenter using Docker.

The lab guided you through the steps necessary to deploy Consul with ACLs enabled for agent RPC communications.

Specifically, you:

- Configured a default-deny policy
- Enabled token persistence through configuration
- Started a server with user-defined configuration
- Bootstrapped the ACL System
- Configured your environment to use the bootstrap token
- Created a server policy
- Associated the server policy with a token
- Registered the server token with the server agent
- Created a client policy
- Associated the client policy with a token
- Registered the client token with the client agent via configuration
- Joined a client agent to an existing datacenter with ACLs enabled and configured.
- Created a read-only policy for non-priveleged access
- Associated the non-priveleged policy with a token
- Verified limited access with non-priveleged token

## Next Steps

If you are already familiar with the basics of Consul, [Secure Consul with ACLs](https://learn.hashicorp.com/consul/security-networking/production-acls) provides a reference guide for the steps required to enable and use ACLs on your Consul datacenter.
