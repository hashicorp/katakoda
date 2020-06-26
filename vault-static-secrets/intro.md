![Vault logo](./assets/Vault_Icon_FullColor.png)

> This scenario supplements the [Versioned Key/Value Secrets Engine](https://learn.hashicorp.com/vault/secrets-management/sm-versioned-kv) guide.

[HashiCorp Vault](https://www.vaultproject.io)'s secrets engines are components responsible for managing secrets:

- Secrets are pieces of sensitive information that can be used to access infrastructure, resources, data, etc.
- Some secrets engines simply store and read data
    - Like encrypted Redis/Memcached
- Some connect to other services and generate dynamic credentials on-demand
- Others provide encryption as a service (EaaS), TOTP generation, certificates, etc.

This scenario demonstrates the [key/value secrets engine v2](https://www.vaultproject.io/docs/secrets/kv/index.html).

Key/Value secrets engine is used to store arbitrary secrets:

- Secrets are accessible via interactive or automated means
- Enforced access control via policies
- Fully audited access

> The secrets are ***encrypted*** using 256-bits AES in GCM mode with a randomly generated nonce prior to writing them to its storage backend.
Anything that leaves Vault is encrypted.
