Jetstack's cert-manager is a Kubernetes add-on that automates the management and
issuance of TLS certificates from various issuing sources. Vault can be
configured as one of those sources. The cert-manager requires the creation of
a set of Kubernetes resources that provide the interface to the certificate
creation.

Install Jetstack's cert-manager's version 0.14.3 resources.

```shell
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.14.3/cert-manager.crds.yaml
```{{execute}}

Create a namespace named `cert-manager` to host the cert-manager.

```shell
kubectl create namespace cert-manager
```{{execute}}

Jetstack's cert-manager Helm chart is available in a repository that they
maintain. Helm can request and install Helm charts from these custom
repositories.

Add the `jetstack` chart repository.

```shell
helm repo add jetstack https://charts.jetstack.io
```{{execute}}

Helm maintains a cached list of charts for every repository that it maintains.
This list needs to be updated periodically so that Helm knows about all
available charts and their releases. A repository recently added needs to be
updated before any chart is requested.

Update the local list of Helm charts.

```shell
helm repo update
```{{execute}}

The results show that the `jetstack` chart repository has retrieved an update.

Install the cert-manager chart version 0.11 in the `cert-manager` namespace.

```shell
helm install cert-manager \
  --namespace cert-manager \
  --version v0.14.3 \
  jetstack/cert-manager
```{{execute}}

The cert-manager chart deploys a number of pods within the `cert-manager`
namespace.

Get all the pods within the `cert-manager` namespace.

```shell
kubectl get pods --namespace cert-manager
```{{execute}}

Wait until all the pods prefixed with `cert-manager` are running and ready
(`1/1`).

Thes pods now require configuration to interface with Vault.