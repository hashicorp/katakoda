![Vault logo](./assets/Vault_Icon_FullColor.png)

One of the core features of Vault is the ability to read and write arbitrary secrets securely. This scenario uses the CLI, but there is also a complete [HTTP API](https://www.vaultproject.io/api/index.html) that can be used to programmatically do anything with Vault.

Secrets written to Vault are encrypted and then written to backend storage. For our dev server, backend storage is in-memory, but in production this would more likely be on disk or in [Consul](https://www.consul.io). Vault encrypts the value before it is ever handed to the storage driver. The backend storage mechanism _never_ sees the unencrypted value and doesn't
have the means necessary to decrypt it without Vault.
