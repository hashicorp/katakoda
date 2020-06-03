Similar to how the secrets are bound to a service account they are also bound
to a namespace.

Create the `offsite` namespace.

```shell
kubectl create namespace offsite
```{{execute}}

Set the current context to the offsite namespace.

```shell
kubectl config set-context --current --namespace offsite
```{{execute}}

Apply the deployment and create the service account defined in
`deployment-06-issues.yml`.

```shell
kubectl apply --filename deployment-06-issues.yml
```{{execute}}

Get all the pods within the `offsite` namespace.

```shell
kubectl get pods
```{{execute}}

> **Current context:** The same command is issued but the results are different
because you are now in a different namespace.

The `issues` deployment creates a pod but it never is ready.

View the logs of the `vault-agent-init` container in the `issues` pod.

```shell
kubectl logs $(kubectl get pod -l app=issues -o jsonpath="{.items[0].metadata.name}") --container vault-agent-init
```{{execute}}

The initialization process fails because the **namespace is not authorized**. The
namespace, `offsite` is not assigned to any Vault Kubernetes authentication
role. This failure to authenticate causes the deployment to fail initialization.
