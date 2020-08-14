
Install Prometheus with the following command.

`helm install -f helm/prometheus-values.yaml prometheus stable/prometheus --version "11.7.0" --wait`{{execute interrupt T1}}

You should receive output similar to the following:

```plaintext
NAME: prometheus
...TRUNCATED
https://prometheus.io/
```

Verify the installation using the following command:

`watch kubectl get pods`{{execute T1}}

Once all pods have a status of `Running` the installation is complete.

```plaintext
NAME                                                READY   STATUS    RESTARTS   AGE
...
prometheus-kube-state-metrics                       3/3     Running   0          42m
prometheus-node-exporter                            3/3     Running   0          42m
prometheus-pushgateway                              3/3     Running   0          42m
prometheus-server                                   4/4     Running   0          42m
....
```
