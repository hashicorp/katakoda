# Start Secure Sidecar Proxies

You've started the source and destination services, but they cannot yet reach each other since no secure proxy is running. Let's do that now.

Open a third terminal and run the `consul connect proxy` command.

`consul connect proxy -sidecar-for counting`{{execute}}

No other details are needed because Consul can read the `counting.json` config file to determine the service name and port.

Open a fourth terminal and start a proxy for the `dashboard` service.

`consul connect proxy -sidecar-for dashboard`{{execute}}

No other configuration is needed because Consul has been configured in `dashboard.json` with the name and port of the `dashboard` service, as well as a list of `upstreams` which are services we want to talk to. The `dashboard` service communicates to `localhost:9001` when it wants to communicate to the `counting` service. Consul load balances across all healthy `counting` services defined on the network (and potentially in other datacenters with more advanced multi-datacenter Consul features).

You can verify successful operation in several ways:

- The [Dashboard Application](https://[[HOST_SUBDOMAIN]]-9002-[[KATACODA_HOST]].environments.katacoda.com/) shows a successful connection to the `counting` service. A large number is displayed. It increments every few seconds.
- The [Consul Web UI](https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/) shows green checkmarks for all services and proxies.

