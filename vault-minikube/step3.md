Vault's Helm chart by default launches with a file storage backend. To utilize
the Consul cluster as a storage backend requires Vault to be run in
high-availability mode.

Install the Vault Helm chart version 0.4.0 with pods prefixed with the name
`vault` and apply the values found in `helm-vault-values.yml`{{open}}.

```shell
helm install vault \
    --values helm-vault-values.yml \
    https://github.com/hashicorp/vault-helm/archive/v0.4.0.tar.gz
```{{execute}}

The Vault pod is deployed in the default namespace.

To verify, get all the pods within the `default` namespace.

```shell
kubectl get pods
```{{execute}}

The `vault-0`, `vault-1` and `vault-2` pods report that they are `Running` but
they are not ready `0/1`. That is because Vault in each pod is executes a status
check defined in a [readinessProbe](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#container-probes).

Retrieve the status of Vault on the `vault-0` pod.

```shell
kubectl exec vault-0 -- vault status
```{{execute}}

The [status command](https://www.vaultproject.io/docs/commands/status.html)
reports that Vault is not initialized and that it is
[sealed](https://www.vaultproject.io/docs/concepts/seal/#why).
