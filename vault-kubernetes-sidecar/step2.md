Helm is a package manager that installs and configures all the necessary
components to run Vault in several different modes.

Add the Hashicorp helm repository.

```shell
helm repo add hashicorp https://helm.releases.hashicorp.com
```{{execute}}

Install the latest version of the Vault server running in development mode.

```shell
helm install vault hashicorp/vault --set "server.dev.enabled=true"
```{{execute}}

The Vault pod and Vault Agent Injector pod are deployed in the default namespace.

Display all the pods in the default namespace.

```shell
kubectl get pods
```{{execute}}

The `vault-0` pod runs a Vault server in development mode. The
`vault-agent-injector` pod performs the injection based on the annotations
present or patched on a deployment.

Wait until the `vault-0` pod and Vault injector pod are running and ready
(`1/1`).

