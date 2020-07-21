Next, set configuration options that are required now that TLS is enabled.

### TLS Configuration

First, in **Terminal 3**, forward port 8501 from the Consul server running in
Kubernetes so that you can interract with the Consul CLI from the development host.

Note that with TLS enabled, Consul uses port 8501 instead of 8500 by default.

`kubectl port-forward --address 0.0.0.0 consul-server-0 8501:8501`{{execute T3}}

Set the `CONSUL_HTTP_ADDR` environment variable to use the HTTPS address/port on
the development host in **Terminal 1**.

`export CONSUL_HTTP_ADDR=https://127.0.0.1:8501`{{execute interrupt T1}}

Export the CA file from Kubernetes so that you can pass it to the CLI.

`kubectl get secret consul-ca-cert -o jsonpath="{.data['tls\.crt']}" | base64 --decode > ca.pem`{{execute T1}}

Now, execute `consul members` and provide Consul with the ca-file option to verify TLS
connections.

`consul members -ca-file ca.pem`{{execute T1}}

You now observe a list of all members of the service mesh. This
proves that TLS is being enforced.
