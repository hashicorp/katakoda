You can control which services are allowed to communicate to other services by defining _intentions_ in Consul. Consul intentions are the way that you describe which services should be able to connect to other services.

# Create a Consul Intention to Deny All

In the [Consul UI](https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/), find the _Intentions_ menu in the top navigation.

Click the "Create" button to open the intentions form. Start by defining a default rule that denies all communication between all services. This is achieved by creating an intention from `*` to `*` with a value of `deny`. You can optionally add a description such as "Deny all communication by default."

Save the intention.

# Restart the Dashboard Service

In order for the `deny` intention to take effect, you may need to go to the second terminal tab and kill the `dashboard-service` with `Ctrl-c`. 

Restart the `dashboard-service`.

`PORT=9002 COUNTING_SERVICE_URL=http://localhost:9001 dashboard-service`{{execute}}

View the [dashboard](https://[[HOST_SUBDOMAIN]]-9002-[[KATACODA_HOST]].environments.katacoda.com/) and you will notice that it cannot reach the backend `counting-service`. This is intended.

<img src="https://hashicorp-education.s3-us-west-2.amazonaws.com/katacoda/consul-connect/images/3-3-dashboard-unreachable.png" alt="Demo dashboard cannot reach the counting service" title="Demo dashboard cannot reach the counting service">

In the next step, you'll define an intention that allows the connection between the services.
