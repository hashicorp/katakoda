Application deployments in a Kubernetes cluster can leverage Vault to manage
their secrets. There are situations where you may have an existing Vault service that
is external to the cluster.

In this tutorial, you will run Vault locally, start a Kubernetes cluster with
Minikube, deploy an application that retrieves secrets from this Vault, and
configure an injector only deployment to inject secrets into the pods from this
Vault.
