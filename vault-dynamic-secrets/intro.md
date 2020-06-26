![Vault logo](./assets/Vault_Icon_FullColor.png)

Data protection is a top priority, and database credential rotation is a critical part of any data protection initiative. Each role has a different set of permissions granted to access the database. When a system is attacked by hackers, continuous credential rotation becomes necessary and needs to be
automated.

Applications ask Vault for database credentials rather than setting them as environment variables. The administrator specifies the TTL of the database credentials to enforce its validity so that they are automatically revoked when they are no longer used.

![](./assets/vault-dynamic-secrets.png)

Each app instance can get unique credentials that they don't have to share. By making those credentials short-lived, you reduce the chance that they might be compromised. If an app was compromised, the credentials used by the app can be revoked rather than changing more global sets of credentials.
