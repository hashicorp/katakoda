The Secrets Store CSI driver *secrets-store.csi.k8s.io* allows Kubernetes to
mount multiple secrets, keys, and certs stored in enterprise-grade external
secrets stores into their pods as a volume. Once the Volume is attached, the
data in it is mounted into the container's file system.

Add the Secrets Store CSI driver Helm repository.

```shell
helm repo add secrets-store-csi-driver https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/master/charts
```{{execute}}

Install the latest version of the Kubernetes-Secrets-Store-CSI-Driver.

```shell
helm install csi secrets-store-csi-driver/secrets-store-csi-driver
```{{execute}}

Verify that a secrets-store-csi-driver pod, prefixed with `csi`, is running in
the `default` namespace.

```shell
kubectl get pods
```{{execute}}

The csi-secrets-store-csi-driver pod is displayed here as the pod prefixed with
`csi-secrets-store-csi-driver`.

Wait until the pod is
[`Running`](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase)
and ready (`3/3`).
