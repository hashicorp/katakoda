![Vault logo](./assets/Vault_Icon_FullColor.png)

In most common scenarios, you configure the Vault server to use a storage backend that supports high availability (HA); therefore, the storage backend stores the Vault data while maintaining the HA coordination. However, not all storage backends support HA (e.g. Amazon S3, Cassandra, MSSQL). In some cases, you may need to use a storage backend that does not have HA support which means that you can only have a single-node Vault deployment instead of an HA cluster.

![](./assets/vault-ha-raft-1.png)

When you need to use a storage backend that does not support HA, ha_storage stanza can be specified along with the storage stanza in the Vault server configuration to handle the HA coordination. By doing so, you can add additional Vault nodes for fault tolerance.

> **NOTE:** To use Vault integrated storage as the ha_storage, you must run **Vault 1.5** or later.
