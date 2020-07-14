### TLS Configuration

Next, you will set necessary configuration options now that TLS is enabled.
First, configure Kubernetes to forward port 8501 so that
you can interract with the Consul CLI from the development host. Note that
with TLS enabled, Consul uses port 8501 instead of 8500. This will execute
in **Terminal 3**.

`kubectl port-forward --address 0.0.0.0 katacoda-consul-server-0 8501:8501`{{execute T3}}

Set the CONSUL_HTTP_ADDR environment variable to use the HTTPS address/port on
the development host in **Terminal 1**.

`export CONSUL_HTTP_ADDR=https://127.0.0.1:8501`{{execute interrupt T1}}

Now, execute `consul members`. Note you must provide Consul with a way to verify TLS
connections. In this example, you are providing the CA as a CLI option.

`consul members -ca-file consul-agent-ca.pem`{{execute T1}}

You now observe a list of all members of the service mesh. This
proves that TLS is being enforced.
