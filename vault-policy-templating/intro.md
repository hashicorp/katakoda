![Vault logo](./assets/Vault_Icon_FullColor.png)

## Prerequisites

* [Vault ACL Policies](https://www.katacoda.com/hashicorp/scenarios/vault-policies)
* [Vault Identity - Entities & Groups](https://www.katacoda.com/hashicorp/scenarios/vault-identity)

## Overview

Vault operates on a **secure by default** standard, and as such, an empty policy grants **no permissions** in the system. Therefore, policies must be created to govern the behavior of clients and instrument Role-Based Access Control (RBAC) by specifying access privileges (_authorization_).

Since everything in Vault is path based, policy authors must be aware of all existing paths as well as paths to be created.  

You can specify non-static paths in ACL policies was to use globs (`*`) at the end of paths.

For example:

```hcl
path "transit/keys/*" {
  capabilities = [ "read" ]
}

path "secret/webapp_*" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}
```

However, this makes the management and delegation tasks challenging.

> This guide highlights the use of [**templating**](https://www.vaultproject.io/docs/concepts/policies.html#templated-policies) to set _non-static_ paths in the ACL policies.  This feature was introduced in **Vault 0.11**.

In addition, refer to the following guides:

- [Vault Policies](https://learn.hashicorp.com/vault/identity-access-management/iam-policies) guide
- [Identity: Entities and Groups](https://learn.hashicorp.com/vault/identity-access-management/iam-identity) guide
- [ACL Policy Path Templating](https://learn.hashicorp.com/vault/identity-access-management/policy-templating) guide
