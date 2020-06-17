Pods run with a Kubernetes service account other than the ones defined in the
Vault Kubernetes authentication role are not able to access the secrets defined
at that path.

View the deployment and service account for the `website` application in `deployment-website.yml`{{open}}.

Apply the deployment and service account defined in `deployment-website.yml`.

```shell
kubectl apply --filename deployment-website.yml
```{{execute}}

Get all the pods within the `default` namespace.

```shell
kubectl get pods
```{{execute}}

The website deployment creates a pod but it is **NEVER** ready.

View the logs of the `vault-agent-init` container in the `website` pod.

```shell
kubectl logs $(kubectl get pod -l app=website -o jsonpath="{.items[0].metadata.name}") --container vault-agent-init
```{{execute}}

The initialization process failed because the service account name is not
authorized. The service account, `external-app` is not assigned to any Vault
Kubernetes authentication role. This failure to authenticate causes the
deployment to fail initialization.

View the deployment patch `patch-website.yml`{{open}}.

The patch modifies defines the service account `internal-app`. This Kubernetes
service account is authorized by the Vault Kubernetes authentication role.

Patch the `website` deployment defined in `patch-website.yml`.

```shell
kubectl patch deployment website --patch "$(cat patch-website.yml)"
```{{execute}}

Get all the pods within the `default` namespace.

```shell
kubectl get pods
```{{execute}}

The `website` pod displays that is ready.

Finally, display the secret written to the `website` container in the `website`
pod.

```shell
kubectl exec \
    $(kubectl get pod -l app=website -o jsonpath="{.items[0].metadata.name}") \
    --container website -- cat /vault/secrets/database-config.txt
```{{execute}}

The PostgreSQL connection string is present on the `website` container.

Alternatively, you can define a new Vault Kubernetes role, that enables the
original service account access, and patch the deployment.
