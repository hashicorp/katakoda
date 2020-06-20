The Secrets Store CSI driver allows Kubernetes to mount multiple secrets, keys,
and certs stored in enterprise-grade external secrets stores into their pods as
a volume.

Add the Secrets Store CSI driver Helm repository.

```shell
helm repo add secrets-store-csi-driver https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/master/charts
```{{execute}}

Install the latest version of the Kubernetes-Secrets-Store-CSI-Driver.

```shell
helm install csi secrets-store-csi-driver/secrets-store-csi-driver
```{{execute}}

The Kubernetes-Secrets-Store-CSI-Driver pod is deployed in the default
namespace.

Get all the pods within the default namespace.

```shell
kubectl get pods
```{{execute}}

Wait until the `csi-secrets-store-csi-driver` pod is running and and ready
(`3/3`).
