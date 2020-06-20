The recommended way to run Vault on Kubernetes is via the Helm chart. Helm is a
package manager that installs and configures all the necessary components to run
Vault in several different modes. A Helm chart includes templates that enable
conditional and parameterized execution. These parameters can be set through
command-line arguments or defined in YAML.

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

The Vault server runs in development mode on a single pod
`server.dev.enabled=true`. By default the Helm chart starts a Vault Agent
Injector pod but that is disabled `injector.enabled=false`.

Display all the pods within the default namespace.

```shell
kubectl get pods
```{{execute}}

Wait until the `vault-0` pod is running and ready (`1/1`).

