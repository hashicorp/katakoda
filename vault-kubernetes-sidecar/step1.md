When you started this tutorial a Kubernetes cluster was already started for you.
The initialization process takes several minutes as it retrieves any necessary
dependencies and executes various container images.

Start the Minikube cluster.

```shell
minikube start
```{{execute}}

Verify the status of the Minikube cluster.

```shell
minikube status
```{{execute}}

When the host, kubelet, and apiserver report that they are `Running` the
Kubernetes cluster is ready.
