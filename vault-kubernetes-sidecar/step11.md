Pods run in a namespace other than the ones defined in the Vault Kubernetes
authentication role are **NOT** able to access the secrets defined at that path.

Create the `offsite` namespace.

```shell
kubectl create namespace offsite
```{{execute}}

Set the current context to the offsite namespace.

```shell
kubectl config set-context --current --namespace offsite
```{{execute}}

Create an `internal-app` service account in the offsite namespace.

```shell
kubectl create sa internal-app
```{{execute}}

Open the deployment for the `issues` application in
`deployment-issues.yml`{{open}}.

This file defines a new deployment named `issues` that relies on the
`internal-app` Vault Kubernetes role.

Apply the deployment.

```shell
kubectl apply --filename deployment-issues.yml
```{{execute}}

Get all the pods in the offsite namespace.

```shell
kubectl get pods
```{{execute}}

> **Current context:** The same command is issued but the results are different
because you are now in a different namespace.

The `issues` deployment creates a pod but it is **NEVER** ready.

Display the logs of the `vault-agent-init` container in the `issues` pod.

```shell
kubectl logs $(kubectl get pod -l app=issues -o jsonpath="{.items[0].metadata.name}") --container vault-agent-init
```{{execute}}

The initialization process fails because the **namespace is not authorized**.
The namespace, `offsite` is not assigned to any Vault Kubernetes authentication
role. This failure to authenticate causes the deployment to fail initialization.

Start an interactive shell session on the `vault-0` pod in the default
namespace.

```shell
kubectl exec --namespace default -it vault-0 -- /bin/sh
```{{execute}}

Your system prompt is replaced with a new prompt `/ $`. Commands issued at this
prompt are executed on the `vault-0` container.

Create a Kubernetes authentication role named `offsite-app`.

```shell
vault write auth/kubernetes/role/offsite-app \
    bound_service_account_names=internal-app \
    bound_service_account_namespaces=offsite \
    policies=internal-app \
    ttl=24h
```{{execute}}

Exit the `vault-0` pod.

```shell
exit
```{{execute}}

Open the deployment patch `patch-issues.yml`{{open}}.

The patch performs an update to set the `vault.hashicorp.com/role` to the
Vault Kubernetes role `offsite-app`.

Patch the `issues` deployment.

```shell
kubectl patch deployment issues --patch "$(cat patch-issues.yml)"
```{{execute}}

A new `issues` pod starts alongside the existing pod. When it is ready the
original terminates and removes itself from the list of active pods.

Get all the pods in the offsite namespace.

```shell
kubectl get pods
```{{execute}}

Wait until the re-deployed `issues` pod is running and ready (`2/2`).

Display the secret written to the `issues` container in the `issues` pod.

```shell
kubectl exec \
    $(kubectl get pod -l app=issues -o jsonpath="{.items[0].metadata.name}") \
    --container issues -- cat /vault/secrets/database-config.txt
```{{execute}}

The secrets are rendered in a PostgreSQL connection string.
