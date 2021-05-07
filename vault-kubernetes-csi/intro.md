Kubernetes application pods that rely on Vault to manage their secrets can
retrieve them [directly via network
requests](https://learn.hashicorp.com/vault/getting-started-k8s/minikube) or
maintained on a mounted file system through the Vault Injector service via
[annotations](https://learn.hashicorp.com/tutorials/vault/kubernetes-sidecar) or
attached as ephemeral volumes. This approach of employing empheral volumes to
store secrets is a feature of the Secrets Store extension to the Kubernetes
Container Storage Interface (CSI) driver.

In this tutorial, you will setup Vault and its dependencies with a Helm chart. Then
enable and configure the secrets store CSI driver to create a volume that
contains a secret that you will mount to an application pod.
