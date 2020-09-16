Policies in Vault control what a user can access. In the last section, we learned about authentication. This section is about authorization.

For authentication Vault has multiple options or methods that can be enabled and used. Vault always uses the same format for both authorization and policies. All auth methods map identities back to the core policies that are configured with Vault.

There are some built-in policies that cannot be removed. For example, the `root` and `default` policies are required policies and cannot be deleted. The `default` policy provides a common set of permissions and is included on all tokens by default. The `root` policy gives a token super admin permissions, similar to a root user on a Linux machine.

![Vault logo](./assets/Vault_Icon_FullColor.png)
