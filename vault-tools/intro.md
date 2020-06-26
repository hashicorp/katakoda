![Vault logo](./assets/Vault_Icon_FullColor.png)

> This scenario supplements the [Direct Application Integration](https://learn.hashicorp.com/vault/developer/sm-app-integration) guide.


A modern system requires access to a multitude of secrets: database credentials, API keys for external services, credentials for service-oriented architecture communication, etc. Vault steps in to provide a centralized secret management system. The next step is to decide how your applications acquire the secrets from Vault.

This guide introduces [**Consul Template**](https://github.com/hashicorp/consul-template) and [**Envconsul**](https://github.com/hashicorp/consul-template) to help you determine if these tools speed up the integration of your applications once secrets are securely managed by Vault.


## Consul Template

A stand-alone application that renders data from Consul and Vault onto the target file system. Despite its name, Consul Template does not require a Consul cluster to operate.

Consul Template retrieves secrets from Vault:
- Manages the acquisition and renewal lifecycle
- Requires a valid Vault token to operate


## Envconsul

Envconsul launches a subprocess with environment variables populated from Consul and Vault. Environment variables are dynamically populated, and applications read those environment variables.

**Characteristics:**

- Envconsul does not require a Consul cluster to operate
- Envconsul enables flexibility and portability for applications across systems

<br>

>**NOTE:** Both Consul Template and Envconsul are open source tools.
