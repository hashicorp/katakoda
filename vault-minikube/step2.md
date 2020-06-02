Consul's Helm chart by default starts more services than required to act as
Vault's storage backend.

Install the Consul Helm chart version 0.18.0 with pods prefixed with the name
`consul` and apply the values found in `helm-consul-values.yml`{{open}}.

```shell
helm install consul \
    --values helm-consul-values.yml \
    https://github.com/hashicorp/consul-helm/archive/v0.18.0.tar.gz
```{{execute}}

The installation of the Helm chart displays the namespace, status, and resources
created. The [server](https://www.consul.io/docs/glossary.html#server) and
[client](https://www.consul.io/docs/glossary.html#client) pods are deployed in
the `default` namespace because no namespace was specified or configured as the
default.

To verify, get all the pods within the `default` namespace.

```shell
kubectl get pods
```{{execute}}

The Consul services are displayed here as the pods prefixed with `consul`.

Wait until the server and client report that they are
[`Running`](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase)
and ready (`1/1`).
