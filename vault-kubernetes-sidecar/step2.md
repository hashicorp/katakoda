The recommended way to run Vault on Kubernetes is via the [Helm
chart](https://www.vaultproject.io/docs/platform/k8s/helm.html).
[Helm](https://helm.sh/docs/helm/) is a package manager that installs and
configures all the necessary components to run Vault in several different
modes. A Helm chart includes
[templates](https://helm.sh/docs/chart_template_guide/#the-chart-template-developer-s-guide)
that enable conditional and parameterized execution. These parameters can be set
through command-line arguments or defined in YAML.

Install the Vault Helm chart version 0.5.0 with pods prefixed with the name
`vault`.

```shell
helm install vault \
    --set "server.dev.enabled=true" \
    https://github.com/hashicorp/vault-helm/archive/v0.5.0.tar.gz
```{{execute}}

The Vault pods are deployed in the default namespace.

To verify, get all the pods within the `default` namespace.

```shell
kubectl get pods
```{{execute}}

The `vault-0` pod starts as a Vault service in development mode. A Vault server
run in development mode is automatically initialized and unsealed.

The pod prefixed with `vault-agent-injector-` performs the injection based on
the annotations present or patched on a deployment.

Wait until the server and injector pods report that they are
[`Running`](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase)
and ready (`1/1`).

