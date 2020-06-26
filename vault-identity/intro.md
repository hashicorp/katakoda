![Vault logo](./assets/Vault_Icon_FullColor.png)

> This scenario supplements the [Identity: Entities and Groups](https://learn.hashicorp.com/vault/identity-access-management/iam-identity) guide.

Identity secrets engine is the identity management solution for Vault. It internally maintains the clients who are recognized by [HashiCorp Vault](https://www.vaultproject.io). Each client is internally termed as an _Entity_. An entity can have multiple Aliases. For example, a single user who has accounts in both Github and LDAP, can be mapped to a single entity in Vault that has 2 aliases, one of type Github and one of type LDAP. When a client authenticates via any of the credential backend (except the Token backend), Vault creates a new entity and attaches a new alias to it, if a corresponding entity doesn't already exist. The entity identifier will be tied to the authenticated token. When such tokens are put to use, their entity identifiers are audit logged, marking a trail of actions performed by specific users.


In this lab, you are going to learn the API-based commands to create entities, entity aliases, and groups.  For the purpose of the training, you are going to leverage the userpass auth method.  The challenge exercise walks you through creating an external group by mapping a GitHub group to an identity group.

1. Create an Entity with Alias
2. Test the Entity
3. Create an Internal Group
4. Test the Internal Group
