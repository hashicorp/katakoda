You've started the frontend and backend services, but they cannot yet reach each other since no secure sidecar proxy is running. 

## Start the Counting Sidecar Proxy

Open a third terminal and run the `consul connect proxy` command.

`consul connect proxy -sidecar-for counting`{{execute}}

The output will indicate that the sidecar proxy has started a listner.

```plaintext
==> Consul Connect proxy starting...
    Configuration mode: Agent API
        Sidecar for ID: counting
              Proxy ID: counting-sidecar-proxy
==> Log data will now stream in as it occurs:
    [INFO]  proxy: Proxy loaded config and ready to serve
    [INFO]  proxy: Parsed TLS identity: uri=spiffe://3cd631d0.consul/dc1/svc/counting roots=[pri-1imtnoro.consul.ca.consul]
    [INFO]  proxy: Starting listener: listener="public listener" bind_addr=0.0.0.0:21000
```

No other details are needed because Consul can read the `counting.json` config file to determine the service name and port.

## Start the Counting Sidecar Proxy

Open a fourth terminal and start a proxy for the `dashboard` service.

`consul connect proxy -sidecar-for dashboard`{{execute}}

Again, the output will indicate that the sidecar proxy has started a listner.

No other configuration is needed because Consul has been configured in `dashboard.json` with the name and port of the `dashboard` service, as well as a list of `upstreams` which are services we want to talk to. The `dashboard` service communicates to `localhost:9001` when it wants to communicate to the `counting` service. Consul load balances across all healthy `counting` services defined on the network (and potentially in other datacenters with more advanced multi-datacenter Consul features).

## Verify the Services are Connected

To verify successful operation either view the dashboard service or Consul UI.

- The [dashboard service](https://[[HOST_SUBDOMAIN]]-9002-[[KATACODA_HOST]].environments.katacoda.com/) shows a successful connection to the `counting` service. A large number is displayed. It increments every few seconds.
- The [Consul UI](https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/) shows green checkmarks for all services and sidecar proxies.

