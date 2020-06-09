You launched Vault and the injector service with the Vault Helm chart. Learn
more about the Vault Helm chart by reading the
[documentation](https://www.vaultproject.io/docs/platform/k8s/), exploring the
[project source code](https://github.com/hashicorp/vault-helm), reading the blog
post announcing the ["Injecting Vault Secrets into Kubernetes Pods via a
Sidecar"](https://www.hashicorp.com/blog/injecting-vault-secrets-into-kubernetes-pods-via-a-sidecar),
or the documentation for [Agent Sidecar
Injector](https://www.vaultproject.io/docs/platform/k8s/injector/index.html)

Then you deployed several applications to demonstrate how this new injector
service retrieves and writes these secrets for the applications to use. Explore
how pods can retrieve them [directly via network
requests](https://learn.hashicorp.com/vault/getting-started-k8s/minikube) or secrets
[mounted on ephemeral volumes](https://learn.hashicorp.com/vault/getting-started-k8s/secret-store-driver).
