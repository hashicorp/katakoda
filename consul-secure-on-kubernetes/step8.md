Finally, deploy two sample services and secure them using Consul intentions.

### Deploy sample services

Exit the terminal running on the server container.

`exit`{{execute interrupt T2}}

Deploy a sample backend service to the cluster.

`kubectl apply -f server.yaml`{{execute T1}}

Deploy a downstream client.

`kubectl apply -f client.yaml`{{execute T1}}

Make sure all pods have a status of `Running` before proceeding to the next section.

`watch kubectl get pods`{{execute T1}}

### Configure intentions

With manageSystemACLs set to true, the Consul Helm chart will create a `deny all` intention by default.
Validate that the `deny all` intention is enforced.

`kubectl exec static-client static-client -- curl -s http://127.0.0.1:1234/ `{{execute interrupt T1}}

The command exits with a non-zero exit code.

```plaintext
Defaulting container name to static-client.
Use 'kubectl describe pod/static-client -n default' to see all of the containers in this pod.
command terminated with exit code 7
```

Create an `allow` intention for client to server traffic.

`consul intention create -ca-file ca.pem -allow static-client static-server`{{execute T1}}

Validate the intention allows traffic from the client to the server.
If this fails, wait a few seconds for the intention to be applied, and try again.

`kubectl exec static-client static-client -- curl -s http://127.0.0.1:1234/ `{{execute T1}}

Notice the output now includes `"hello world"`. This proves the client can
communicate with the server.

```plaintext
Defaulting container name to static-client.
Use 'kubectl describe pod/static-client -n default' to see all of the containers in this pod.
"hello world"
```
