Pods run with a Kubernetes service account other than the ones defined in the
Vault Kubernetes authentication role are **NOT** able to access the secrets
defined at that path.

Open the deployment definition in `deployment-website.yml`{{open}}.

This file defines a new deployment named `website` that is run with the
`website` service account. The deployment relies on the `internal-app` Vault
Kubernetes role in the injector annotations.

Create the `website` service account.

```shelll
kubectl create sa website
```{{execute}}

Apply the deployment.

```shell
kubectl apply --filename deployment-website.yml
```{{execute}}

Get all the pods in the default namespace.

```shell
kubectl get pods
```{{execute}}

The `website` deployment creates a pod but it is **NEVER** ready.

Display the logs of the `vault-agent-init` container in the `website` pod.

```shell
kubectl logs $(kubectl get pod -l app=website -o jsonpath="{.items[0].metadata.name}") --container vault-agent-init
```{{execute}}

The initialization process failed because the service account name is not
authorized. The service account, `website` is not assigned to the
`internal-app` Kubernetes authentication role. This failure to authenticate
causes the deployment to fail initialization.

Open the deployment patch `patch-website.yml`{{open}}.

The patch modifies the deployment definition to use the service account
`internal-app`. This Kubernetes service account is authorized by the Vault
Kubernetes authentication role.

Patch the `website` deployment.

```shell
kubectl patch deployment website --patch "$(cat patch-website.yml)"
```{{execute}}

Get all the pods in the default namespace.

```shell
kubectl get pods
```{{execute}}

Wait until the `website` pod is running and ready (`2/2`).

Display the secret written to the `website` container in the `website`
pod.

```shell
kubectl exec \
    $(kubectl get pod -l app=website -o jsonpath="{.items[0].metadata.name}") \
    --container website -- cat /vault/secrets/database-config.txt
```{{execute}}

The secrets are rendered in a PostgreSQL connection string.

> Alternatively, you could define a new Vault Kubernetes role, that enables the
> `website` service account and then patched the `website` deployment
> annotations to use this new role.
