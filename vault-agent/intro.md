![Vault logo](./assets/Vault_Icon_FullColor.png)

> This scenario supplements the [Vault Agent with AWS](Vault Agent with AWS) and [Vault Agent Caching](https://learn.hashicorp.com/vault/identity-access-management/agent-caching) guides.

Nearly all requests to Vault must be accompanied by an authentication token. This includes all API requests, as well as via the Vault CLI and other libraries.

Although a number of [auth methods](https://www.vaultproject.io/docs/auth/index.html) are available, the client is still responsible for managing the lifecycle of its Vault tokens. Therefore, the challenge becomes how to enable authentication to Vault and manage the **lifecycle** of tokens in a standard way without having to write custom logic.

[Vault Agent](https://www.vaultproject.io/docs/agent/index.html) provides a number of different helper features, specifically addressing the following challenges:

- Automatic authentication
- Secure delivery/storage of tokens
- Lifecycle management of these tokens (renewal & re-authentication)


Depending on the location of your Vault clients and its secret access frequency, you may face some scaling or latency challenge. Even with Vault Performance Replication enabled, the pressure on the storage backend increases as the number of token or lease generation requests increase. Vault 1.0 introduced [batch tokens](https://www.vaultproject.io/docs/concepts/tokens.html#batch-tokens) as a
solution to relieve some pressure on the storage backend. By design, batch tokens do not support the same level of flexibility and features as service tokens. Therefore, if you need an orphan token for example, you would need service tokens.

To increase the availability of tokens and secrets to the clients, [Vault Agent](https://www.vaultproject.io/docs/agent/index.html) introduced the **Caching** function.

Vault Agent Caching can cache the tokens and leased secrets proxied through the agent which includes the auto-auth token. This allows for easier access to Vault secrets for edge applications, reduces the I/O burden for basic secrets access for Vault clusters, and allows for secure local access to leased secrets for the life of a valid token.


This lab demonstrates the Vault Agent workflow.

1. Run Vault Agent
1. Test Vault Agent Caching
1. Evict Cached Leases
