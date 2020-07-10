You deployed Vault external to a Kubernetes cluster and deployed pods that
leveraged it as a secrets store. First, through a hard-coded network address.
Second, aliased behind a Kubernetes service and endpoint. And finally, through
the Vault Helm's chart and the injector service with annotations applied to a
deployment. Learn more about the Vault Helm chart by reading the
[documentation](https://www.vaultproject.io/docs/platform/k8s/), exploring the
[project source code](https://github.com/hashicorp/vault-helm), exploring how
pods can retrieve secrets through the [Vault Injector service via
annotations](https://learn.hashicorp.com/vault/getting-started-k8s/sidecar), or secrets [mounted on
ephemeral volumes](https://learn.hashicorp.com/vault/getting-started-k8s/secret-store-driver).
