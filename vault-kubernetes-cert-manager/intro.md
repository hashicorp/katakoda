Kubernetes configured to use Vault as a certificate manager enables your
services to establish their identity and communicate securely over the network
with other services or clients internal or external to the cluster.

Jetstack's [cert-manager](https://cert-manager.io/) enables Vault's [PKI secrets
engine](https://www.vaultproject.io/docs/secrets/pki) to dynamically generate
X.509 certificates within Kubernetes through an Issuer interface.

In this guide, you setup Vault with the Vault Helm chart, configure the PKI
secrets engine and Kubernetes authentication. Then install Jetstack's
cert-manager, configure it to use Vault, and request a certificate.
