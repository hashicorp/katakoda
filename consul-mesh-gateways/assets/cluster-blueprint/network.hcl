# Components like `k8s_cluster` and `ingress` need a `network` parameter to be defined
# You can use this file to define netwokrs in your k8s cluster.

## Define network `local`
network "local" {
  subnet = "10.5.0.0/16"
}
