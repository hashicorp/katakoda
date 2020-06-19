The Kubernetes Container Storage Interface (CSI) is an extensible approach to
the management of storage alongside the lifecycle of containers. Learn more
about the [Secrets Store CSI
driver](https://github.com/kubernetes-sigs/secrets-store-csi-driver) and the
[Vault
provider](https://github.com/hashicorp/secrets-store-csi-driver-provider-vault)
in this guide to accomplish the secrets management for the container.

Secrets mounted on empheral volumes is one approach to manage secrets for
applications pods. Explore how pods can retrieve them [directly via network
requests](https://learn.hashicorp.com/vault/getting-started-k8s/minikube) and through the Vault Injector
service via [annotations](https://learn.hashicorp.com/vault/getting-started-k8s/sidecar).
