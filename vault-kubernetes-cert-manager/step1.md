Minikube is a CLI tool that provisions and manages the lifecycle of single-node
Kubernetes clusters running inside Virtual Machines (VM) on your local system.

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

```shell
minikube status
```{{execute}}

When the host, kubelet, and apiserver report that they are `Running` the
Kubernetes cluster is ready.
