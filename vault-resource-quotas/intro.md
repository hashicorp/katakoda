![Vault logo](./assets/Vault_Icon_FullColor.png)

**Vault 1.5** introduced **resource quotas** to protect your Vault environment's stability and network, as well as storage resource consumption from runaway application behavior and distributed denial of service (DDoS) attack.

The Vault operators can control how applications request resources from Vault, and Vault's storage and network infrastructure by setting the following:

  - **Rate Limit Quotas**: Limit maximum amount of requests per second (RPS) to a system or mount to protect network bandwidth
  - **Lease Count Quotas** (_Vault Enterprise_ only): Cap number of leases generated in a system or mount to protect system stability and storage performance at scale


> **Important Note:** Without a valid license, Vault Enterprise server will be sealed after ***6 hours***. To explore Vault Enterprise further, you can [sign up for a free 30-day trial](https://www.hashicorp.com/products/vault/trial).
