The Vault Agent Injector only modifies a deployment if it contains a specific
set of annotations. An existing deployment may have its definition patched to
include the necessary annotations.

Open the deployment patch `patch-02-inject-secrets.yml`{{open}}.

These
[annotations](https://www.vaultproject.io/docs/platform/k8s/injector/index.html#annotations)
define a partial structure of the deployment schema and are prefixed with
`vault.hashicorp.com`.

- `agent-inject` enables the Vault Agent Injector service
- `role` is the Vault Kubernetes authentication role
- `agent-inject-secret-FILEPATH` prefixes the path of the file,
  `credentials.txt` written to the `/vault/secrets` directory. The value
  is the path to the secret defined in Vault.

Patch the existing `devwebapp` deployment with the annoations to write the
secrets to the pod.

```shell
kubectl patch deployment devwebapp --patch "$(cat patch-02-inject-secrets.yml)"
```{{execute}}

A new `devwebapp` pod starts alongside the existing pod. When it is ready the
original terminates and removes itself from the list of active pods.

Get all the pods within the default namespace.

```shell
kubectl get pods
```{{execute}}

Wait until the re-deployed `devwebapp` pod reports that it is running and ready
(`2/2`).

The Vault Agent Injector service automatically writes the secrets to the
`devwebapp` pod at the filepath `/vault/secrets/credentials.txt`.

Display the secrets written to the file `/vault/secrets/secret-credentials.txt`
on the `devwebapp` pod.

```shell
kubectl exec \
  $(kubectl get pod -l app=devwebapp -o jsonpath="{.items[0].metadata.name}") \
  -c app -- curl http://localhost:8080
```{{execute}}

The unformatted secret data is present on the container.
