Consul is already running on a publicly accessible IP address. 

# Access the Consul UI

The Consul web UI runs on port `8500`. Visit it in a new tab here:

- [Consul Web UI](https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/)

Since health checks have been configured, there will be a red `X` next to the `counting`, `counting-sidecar-proxy`, `dashboard`, and `dashboard-sidecar-proxy`. The services are not healthy because they are not running.

# Start the Backend Service

Start the backend service, `counting-service`. First, you'll examine the configuration for this service and then start the it on port `9003`.

The service definition instructs Consul to look for the `counting-service` on port `9003`. You can see the service definition by looking at the configuration file at `/etc/consul.d/counting.json`.

`cat /etc/consul.d/counting.json`{{execute}}

There are three important settings in the service definition.

- Consul will look for a service running on port `9003`. It will advertise that as the `counting` service. On a properly configured node, this can be reached as `counting.service.consul` through Consul DNS interface.
- A service sidecar proxy is defined. This enables proxy communication through Consul service mesh but doesn't define any connections right away. The proxy must be manually started, which we will do later.
- A health check examines the local `/health` endpoint every second to determine whether the service is healthy and can be exposed to other services.

Now, start the service, specifying `PORT` as an environment variable.

`PORT=9003 counting-service`{{execute}}

Review the output of the counting service at this URL. It's a JSON API with a few keys and values.

- [Counting Service JSON](https://[[HOST_SUBDOMAIN]]-9003-[[KATACODA_HOST]].environments.katacoda.com/)

If you go back to the [Consul Web UI](https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/), you'll notice that it automatically updated the `counting` service which is now healthy and the red `X` is gone.
