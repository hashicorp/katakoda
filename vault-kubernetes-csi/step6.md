The Secrets Store CSI driver enables extension through providers. A provider
is launched as a Kubernetes DaemonSet alongside of Secrets Store CSI driver
DaemonSet.

View the definition of the DaemonSet `daemon-set-provider-vault.yml`{{open}}.

This DaemonSet launches its own provider pod with the name prefixed with
`csi-secrets-store-provider-vault` and mounts the executable in the existing
csi-secrets-store-csi-driver pod.

Define a DaemonSet to install the `provider-vault` executable for the
Kubernetes-Secrets-Store-CSI-Driver.

```shell
kubectl apply --filename daemon-set-provider-vault.yml
```{{execute}}

Wait until `csi-secrets-store-provider-vault` is [`Running`](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase)
and ready (`1/1`).

Verify that a csi-secrets-store-provider-vault pod, prefixed with
`csi-secrets-store-provider-vault`, is running in the `default` namespace.

```shell
kubectl get pods
```{{execute}}

Verify that the `provider-vault` executable is present on the `secrets-store`
container in the `secrets-store-csi-driver` pod.

```shell
kubectl exec \
  $(kubectl get pod -l app=secrets-store-csi-driver -o jsonpath="{.items[0].metadata.name}") \
  -c secrets-store -- \
  stat /etc/kubernetes/secrets-store-csi-providers/vault/provider-vault
```{{execute}}

The executable enables the `vault` provider when you define a
*SecretProviderClass*.