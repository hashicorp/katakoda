# View Consul UI and Launch Counting Service

We're already running Consul for you on a publically accessible IP address. The Consul web UI runs on port `8500`. Visit it in a new tab here:

- [Consul Web UI](https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/)

To start, you'll see a red `X` next to the `counting` and `dashboard` services since neither are running (so both are unhealthy).

<img src="https://s3-us-west-1.amazonaws.com/education-yh/consul-connect/images/1-1-web-ui.png" alt="Consul Web UI" title="Consul Web UI">

Now let's start some services. Connect to `host01`. You'll examine the configuration for this service and then start the `counting-service` on port `9003`.

`ssh root@host01`{{execute}}

Consul is configured to look for the `counting-service` on port `9003`. You can see the configuration by looking at the configuration file at `/etc/consul.d/counting.json`.

`cat /etc/consul.d/counting.json`{{execute}}

There are three important settings here.

* Consul will look for a service running on port 9003. It will advertise that as the `counting` service. On a properly configured node, this can be reached as `counting.service.consul` through DNS.
* A blank proxy is defined. This enables proxy communication through Consul Connect but doesn't define any connections right away.
* A health check examines the local `/health` endpoint every second to determine whether the service is healthy and can be exposed to other services.

Now, start the service, specifying `PORT` as an environment variable.

`PORT=9003 counting-service`{{execute}}

You can view the output of the counting service at this URL. It's a simple JSON API.

- [Counting Service JSON](https://[[HOST_SUBDOMAIN]]-9003-[[KATACODA_HOST]].environments.katacoda.com/)

Now refresh the [Consul Web UI](https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/). You'll notice that the `counting` service now shows as healthy.
