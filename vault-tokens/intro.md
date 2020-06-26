![Vault logo](./assets/Vault_Icon_FullColor.png)

> This scenario supplements the [Tokens](https://learn.hashicorp.com/vault/identity-access-management/tokens) guide.


Before a client can interact with [HashiCorp Vault](https://www.vaultproject.io), it must authenticate against an [**auth method**](/docs/auth/index.html) to acquire a token. This token has policies attached so that the behavior of the client can be governed.

Since tokens are the core method for authentication within Vault, there is a **token** auth method (often referred to as **_token store_**). This is a special auth method responsible for creating and storing tokens.

Consider the following scenarios often encountered outside of Vault:

- There is no **break glass** procedure available for revoking access to credentials in the event of a breach
- Credentials for external systems (e.g. AWS, MySQL) are shared
- Need temporal access to a database in a specific scenario

## Solution

Vault has built-in support for secret revocation. Vault can revoke not only a single secret, but also a tree of secrets. For example, Vault can revoke all secrets read by a specific **user** or all secrets of a specific **type**. Revocation assists in key rolling as well as locking down systems in the case of an intrusion.

If a user or machine needs a temporal access to Vault, you can set a short TTL or a number of uses to a token so the token is automatically revoked at the end of its life.

This also allows for organizations to plan and train for various "break glass" procedures.


Almost all operations in [HashiCorp Vault](https://www.vaultproject.io) requires a token; therefore, it is important to understand the token lifecycle as well as different token parameters that affects the token's lifecycle.  This lab demonstrates various token parameters.  

1. Create a Short-Lived Tokens
1. Token Renewal
1. Create Tokens with Use Limit
1. Create a Token Role and Periodic Token
1. Create an Orphan Token
1. Get the service token count
