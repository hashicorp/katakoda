Minikube is a CLI tool that provisions and manages the lifecycle of single-node
Kubernetes clusters running inside Virtual Machines (VM) on your local system.

Verify the `minikube` CLI is installed.

```shell
minikube version
```{{execute}}

Wait until the `minikube version` command returns a value.

Start the Minikube cluster.

```shell
minikube start \
    --vm-driver none \
    --bootstrapper kubeadm \
    --extra-config=apiserver.service-account-signing-key-file=/var/lib/minikube/certs/sa.key \
    --extra-config=apiserver.service-account-issuer=https://kubernetes.default.svc.cluster.local
```{{execute}}

Verify the status of the Minikube cluster.

```
minikube status
```{{execute}}

When the host, kubelet, and apiserver report that they are `Running` the
Kubernetes cluster is ready.
