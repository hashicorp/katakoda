
Start the traffic simulation pod with the following command. Be patient. It may take a moment to finish initializing.

`kubectl apply -f traffic.yaml`{{execute interrupt T1}}

You will receive the following output.

```plaintext
configmap/k6-configmap created
deployment.apps/traffic created
```
