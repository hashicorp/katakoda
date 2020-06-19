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

Install the latest version of the Vault server running in development mode with
the injector service disabled.

```shell
helm install vault hashicorp/vault \
    --set "server.dev.enabled=true" \
    --set "injector.enabled=false"
```{{execute}}

The Vault pods are deployed in the default namespace.

To verify, get all the pods within the `default` namespace.

```shell
kubectl get pods
```{{execute}}

The `vault-0` pod starts as a Vault service in development mode. A Vault server
run in development mode is automatically initialized and unsealed.

Wait until the server reports that they are
[`Running`](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase)
and ready (`1/1`).

