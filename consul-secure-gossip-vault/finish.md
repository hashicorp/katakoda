## Review

In this hands-on lab, you enabled gossip encryption
in Consul using Vault to store and retrieve the
encryption key.

Specifically, you:

- Started a Vault dev instance
- Enabled the KV store in Vault
- Generated a gossip key for Consul
- Stored the gossip key as a secret in Vault
- Retrieved the gossip key from Vault
- Configured and started Consul
- Used consul-template to automate gossip key rotation

## Next Steps

If you are already familiar with the basics of Consul,
[Secure Gossip Communication with Encryption](https://learn.hashicorp.com/tutorials/consul/gossip-encryption-secure)
provides a reference guide for the steps required to
enable gossip encryption on both new and existing datacenters.
