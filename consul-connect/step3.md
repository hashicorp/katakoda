# Lock Down Connections with `deny`

Let's secure these services by defining intentions in Consul. Intentions are the way that we describe which services should be able to connect to other services.

In the [Consul Web UI](https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/), find the _Intentions_ menu. It may be hidden behind the overflow menu (three dots).

<img src="https://s3-us-west-1.amazonaws.com/education-yh/consul-connect/images/3-1-intentions-menu.png" alt="Intentions menu" title="Intentions menu">

Click the blue "Create" button to open the intentions form. Start by defining a default rule that denies all communication between all services. This is achived be creating an intention from `*` to `*` with a value of `deny`. You can optionally add a description such as "Deny all communication by default."

<img src="https://s3-us-west-1.amazonaws.com/education-yh/consul-connect/images/3-2-deny.png" alt="Default deny intention" title="Default deny intention">

Save the intention.

Since existing proxies will not be terminated when a `deny` rule is created, we must restart the `dashboard-service`. Kill it with `Ctrl-C` in Terminal 2.

Restart the service.

`PORT=9002 dashboard-service`{{execute}}

Refresh the [Demo Dashboard](https://[[HOST_SUBDOMAIN]]-9002-[[KATACODA_HOST]].environments.katacoda.com/) and you will see that it cannot reach the backend `counting-service`. This is intended.

<img src="https://s3-us-west-1.amazonaws.com/education-yh/consul-connect/images/3-3-dashboard-unreachable.png" alt="Demo dashboard cannot reach the counting service" title="Demo dashboard cannot reach the counting service">

In the next step, you'll restore the connection between the services.
