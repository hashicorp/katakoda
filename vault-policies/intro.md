[HashiCorp Vault](https://www.vaultproject.io) secures, stores, and tightly controls access to tokens, passwords, certificates, API keys, and other secrets in modern computing.

[![YouTube](https://s3-us-west-1.amazonaws.com/education-yh/Armon_whiteboard.png)](https://youtu.be/VYfl-DpZ5wM)


Vault uses [policies](https://www.vaultproject.io/docs/concepts/policies.html) to govern the behavior of clients and instrument Role-Based Access Control (RBAC) by specifying access privileges (authorization).

When you first initialize Vault, the root policy gets created by default. This root policy is a special policy that gives superuser access to everything in Vault. Therefore, it is recommended that a token with root policy is used for just enough initial setup or in emergencies. As a best practice, use tokens with an appropriate set of policies based on your role in the organization.

<br>

In this scenario, you will learn how to write an ACL policy in Vault.

<img src="https://s3-us-west-1.amazonaws.com/education-yh/Vault_Icon_FullColor.png" alt="Logo"/>
