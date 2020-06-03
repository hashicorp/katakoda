You launched Vault in high-availability mode with a Helm chart. Learn more about
the Vault Helm chart by reading the
[documentation](https://www.vaultproject.io/docs/platform/k8s/) or exploring the
[project source code](https://github.com/hashicorp/vault-helm).

Then you deployed a web application that authenticated and requested a secret
directly from Vault. Explore how pods can retrieve secrets through the [Vault
Injector service via annotations](/vault/getting-started-k8s/sidecar) or secrets
[mounted on ephemeral
volumes](https://learn.hashicorp.com/vault/getting-started-k8s/secret-store-driver).

Finally, Consul is more than a storage backend for Vault. Explore running
[Consul on Minikube via
Helm](https://learn.hashicorp.com/consul/kubernetes/minikube) and its
integrations with Kubernetes (including multi-cloud, service sync, and other
features) in the [Consul
documentation](https://consul.io/docs/platform/k8s/index.html).
