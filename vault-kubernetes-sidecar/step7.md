The deployment is running the pod with the `internal-app` Kubernetes service
account in the `default` namespace. The Vault Agent injector only modifies a
deployment if it contains a specific set of annotations. An existing deployment
may have its definition patched to include the necessary annotations.

View the deployment patch `patch-inject-secrets.yml`{{open}}.

These
[annotations](https://www.vaultproject.io/docs/platform/k8s/injector/index.html#annotations)
define a partial structure of the deployment schema and are prefixed with
`vault.hashicorp.com`.

- `agent-inject` enables the Vault Agent injector service
- `role` is the Vault Kubernetes authentication role
- `agent-inject-secret-FILEPATH` prefixes the path of the file,
  `database-config.txt` written to the `/vault/secrets` directory. The value
  is the path to the secret defined in Vault.

Patch the `orgchart` deployment defined in `patch-inject-secrets.yml`.

```shell
kubectl patch deployment orgchart --patch "$(cat patch-inject-secrets.yml)"
```{{execute}}

The original orgchart pod is terminated and a new orgchart pod is created.

Get all the pods within the `default` namespace.

```shell
kubectl get pods
```{{execute}}

A new `orgchart` pod starts alongside the existing pod. When it is ready the
original terminates and removes itself from the list of active pods.

Wait until the redeployment is complete and the new pod reports `READY 2/2`.

This new pod now launches two containers. The application container, named
`orgchart`, and the Vault Agent container, named `vault-agent`.

View the logs of the `vault-agent` container in the new `orgchart` pod.

```shell
kubectl logs $(kubectl get pod -l app=orgchart -o jsonpath="{.items[0].metadata.name}") --container vault-agent
```{{execute}}

Finally, view the secret written to the `orgchart` container.

```shell
kubectl exec $(kubectl get pod -l app=orgchart -o jsonpath="{.items[0].metadata.name}") --container orgchart -- cat /vault/secrets/database-config.txt
```{{execute}}

The unformatted secret data is present on the container.