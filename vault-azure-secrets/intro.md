Dynamic secrets are a core feature in Vault. A class of dynamic secrets is
on-demand, revocable, time-limited access credentials for cloud providers. For
example, the [Dynamic Secrets](/tutorials/vault/getting-started-dynamic-secrets)
getting started tutorial demonstrated the AWS secrets engine to dynamically
generate AWS credentials (access key ID and secret access key).

Automate the process by integrating your applications with Vault's Azure secrets
engine. The applications ask Vault for Azure credential with a time-to-live
(TTL) enforcing its validity so that the credentials are automatically revoked
when they are no longer used.

![](vault-azure-secrets-0.png)
