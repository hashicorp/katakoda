The recommended way to run Vault on OpenShift is via the Helm chart. Helm is a
package manager that installs and configures all the necessary components to run
Vault in several different modes.

Add the HashiCorp Helm repository.

```shell
helm repo add hashicorp https://helm.releases.hashicorp.com
```{{execute}}

Install the latest version of the Vault server running in development mode.

```shell
helm install vault hashicorp/vault \
  --set "global.openshift=true" \
  --set "server.dev.enabled=true"
```{{execute}}

The Vault pod and Vault Agent Injector pod are deployed in the default
namespace.

Display all the pods within the default namespace.

```shell
oc get pods
```{{execute}}

The `vault-0` pod runs a Vault server in development mode. The
`vault-agent-injector` pod performs the injection based on the annotations
present or patched on a deployment.

Wait until the `vault-0` pod and `vault-agent-injector` are running and ready
(`1/1`).

