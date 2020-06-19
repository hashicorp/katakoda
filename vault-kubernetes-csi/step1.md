When you started this tutorial a Kubernetes cluster was already started for you.
The initialization process takes several minutes as it retrieves any necessary
dependencies and executes various container images.

Verify the `minikube` CLI is installed.

```shell
minikube version
```{{execute}}

Wait until the `minikube version` command returns a value.

Start the Minikube cluster.

```shell
minikube start --vm-driver none --bootstrapper kubeadm
```{{execute}}

Verify the status of the Minikube cluster.

```
minikube status
```{{execute}}

When the host, kubelet, and apiserver report that they are `Running` the
Kubernetes cluster is ready.
