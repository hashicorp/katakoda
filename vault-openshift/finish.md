You launched Vault within OpenShift with a Helm chart. Learn more about
the Vault Helm chart by reading the
[documentation](https://www.vaultproject.io/docs/platform/k8s/) or exploring the
[project source code](https://github.com/hashicorp/vault-helm).

Then you deployed a web application that authenticated and requested a secret
directly from Vault. And finally, deployed a web application that injected
secrets based on deployment annotations supported by the Vault Agent Injector
service. Learn more by reading the blog post announcing the ["Injecting Vault
Secrets into Kubernetes Pods via a
Sidecar"](https://www.hashicorp.com/blog/injecting-vault-secrets-into-kubernetes-pods-via-a-sidecar),
or the documentation for [Vault Agent
Injector](https://www.vaultproject.io/docs/platform/k8s/injector/index.html)
service.

