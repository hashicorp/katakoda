First, install Consul service mesh in a Kubernetes cluster.
Click the box below to download the Helm repo:

`git clone https://github.com/hashicorp/consul-k8s-prometheus-grafana-hashicups-demoapp.git`{{execute T1}}

Now, change directories into the downloaded repository.

`cd consul-k8s-prometheus-grafana-hashicups-demoapp`{{execute T1}}

Review the `helm/consul-values.yaml`{{open}} file. Note the `proxyDefaults` entry. Consul uses that setting to configure where Envoy will publish Prometheus metrics.

`helm install -f helm/consul-values.yaml consul hashicorp/consul --version "0.23.1" --wait`{{execute T1}}

You should receive output similar to the following:

```plaintext
NAME: consul
...TRUNCATED
  $ helm status consul
  $ helm get all consul
```

Verify the installation using the following command:

`watch kubectl get pods`{{execute T1}}

Once all pods have a status of `Running` the installation is complete.

```plaintext
NAME                                                 READY   STATUS    RESTARTS   AGE
consul-7d4h2                                         1/1     Running   0          82s
consul-connect-injector-webhook-deployment           1/1     Running   0          94s
consul-server-0                                      1/1     Running   0          93s
```
