The recommended way to run Vault on Kubernetes is via the [Helm
chart](https://www.vaultproject.io/docs/platform/k8s/helm.html).
[Helm](https://helm.sh/docs/helm/) is a package manager that installs and
configures all the necessary components to run Vault in several different
modes. A Helm chart includes
[templates](https://helm.sh/docs/chart_template_guide/#the-chart-template-developer-s-guide)
that enable conditional and parameterized execution. These parameters can be set
through command-line arguments or defined in YAML.

Add the Hashicorp helm repository.

```shell
helm repo add hashicorp https://helm.releases.hashicorp.com
```{{execute}}

Install the latest version of the Vault server running in standalone mode with
the Vault Agent Injector service disabled.


```shell
helm install vault hashicorp/vault --set "injector.enabled=false"
```{{execute}}

The Vault pods are deployed in the default namespace.

Display all the pods within the default namespace.

```shell
kubectl get pods
```{{execute}}

Wait until the `vault-0` pod reports that it is running and not ready (`0/1`).
