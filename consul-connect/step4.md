# Lock Down Connections with `deny`

Let's control which services are allowed to communicate to other services by defining _intentions_ in Consul. Intentions are the way that we describe which services should be able to connect to other services.

In the [Consul Web UI](https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/), find the _Intentions_ menu. It may be hidden behind the overflow menu (three dots).

<img src="https://hashicorp-education.s3-us-west-2.amazonaws.com/katacoda/consul-connect/images/3-1-intentions-menu.png" alt="Intentions menu" title="Intentions menu">

Click the blue "Create" button to open the intentions form. Start by defining a default rule that denies all communication between all services. This is achieved by creating an intention from `*` to `*` with a value of `deny`. You can optionally add a description such as "Deny all communication by default."

<img src="https://hashicorp-education.s3-us-west-2.amazonaws.com/katacoda/consul-connect/images/3-2-deny.png" alt="Default deny intention" title="Default deny intention">

Save the intention.

In order for the `deny` intention to take effect, you may need to go to the second terminal tab and kill the `dashboard` service with `Ctrl-c`. Type the up arrow and hit `ENTER` to start it again.

View the [Demo Dashboard](https://[[HOST_SUBDOMAIN]]-9002-[[KATACODA_HOST]].environments.katacoda.com/) and you will see that it cannot reach the backend `counting-service`. This is intended.

<img src="https://hashicorp-education.s3-us-west-2.amazonaws.com/katacoda/consul-connect/images/3-3-dashboard-unreachable.png" alt="Demo dashboard cannot reach the counting service" title="Demo dashboard cannot reach the counting service">

In the next step, you'll define an intention that allows the connection between the services.
