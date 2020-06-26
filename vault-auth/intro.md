![Vault logo](./assets/Vault_Icon_FullColor.png)

[Vault's auth methods](https://www.vaultproject.io/docs/concepts/auth.html) perform authentication to verify the user or machine-supplied information. Some of the supported auth methods are targeted towards users while others are targeted toward machines or apps. For example, [LDAP](https://www.vaultproject.io/docs/auth/ldap.html) auth method enables user authentication using an existing LDAP server while [AppRole](https://www.vaultproject.io/docs/auth/approle.html) auth method is recommended for machines or apps.

The [Getting Started](https://learn.hashicorp.com/vault/) guide walks you through how to enable the GitHub auth method for user authentication.

This scenario demonstrates the **`userpass`** auth method which allows users to authenticate with Vault using a username and password combination.
