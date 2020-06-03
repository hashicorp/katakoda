The Vault Helm chart enables you to run Vault and the Vault Agent injector
service. This injector service leverages the Kubernetes mutating admission
webhook to intercept pods that define specific annotations and inject a Vault
Agent container to manage these secrets. This is beneficial because:

- Applications remain Vault unaware as the secrets are stored on the file-system
  within their container.
- Existing deployments require no change; as annotations can be patched.
- Access to secrets can be enforced via Kubernetes service accounts and
  namespaces

In this tutorial, you setup Vault and this injector service with the Vault Helm
chart. Then you will deploy several applications to demonstrate how this new injector
service retrieves and writes these secrets for the applications to use.