# Secure Consul Agent Communication with ACL

In this hands-on lab, you will deploy a secure Consul datacenter using Docker.

The lab will guide you through the steps necessary to deploy Consul with ACLs enabled to secure acces to the UI, API, CLI, services, and agents.

Specifically, you will:

- Configure a default-deny policy
- Enable token persistence through configuration
- Start a server with user-defined configuration
- Bootstrap the ACL System
- Configure your environment to use the bootstrap token
- Create a server policy
- Associate the server policy with a token
- Register the server token with the server agent
- Create a client policy
- Associate the client policy with a token
- Register the client token with the client agent via configuration
- Join a client agent to an existing datacenter with ACLs enabled and configured.
- Create a read-only policy for non-priveleged access
- Associate the non-priveleged policy with a token
- Verify limited access with non-priveleged token

If you are already familiar with the basics of Consul, [Secure Consul with ACLs](https://learn.hashicorp.com/consul/security-networking/production-acls) provides a reference guide for the steps required to enable and use ACLs on your Consul datacenter.
