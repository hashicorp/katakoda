
#### Start Minikube

You first need to start your Minikube environment:

`minikube start --wait=false`{{execute}}

This will create a local Kubernetes cluster using Minikube.

#### Health Check

Once the first command has completed, check the state of your Kubernetes cluster.

`kubectl cluster-info`{{execute}}

