The Vault Kubernetes authentication role defined a Kubernetes service account
named `internal-app`.

Get all the service accounts in the default namespace.

```shell
kubectl get serviceaccounts
```{{execute}}

The `internal-app` service account does not exist.

Create the `internal-app` service account.

```shell
kubectl create sa internal-app
```{{execute}}

Get all the service accounts within the default namespace.

```shell
kubectl get serviceaccounts
```{{execute}}

The `internal-app` service account is created.
