# Launch Demo Dashboard

Next, connect to `host01` in a second terminal. You'll start the front-end `dashboard-service` on port `9002` and it will communicate to the `counting` service through an encrypted proxy.

Click the **+** button in the tab bar and select **Open New Terminal**.

<img src="https://s3-us-west-1.amazonaws.com/education-yh/consul-connect/images/2-1-new-tab.png" alt="Consul Web UI" title="Consul Web UI">

Now connect to `host01` again.

`ssh root@host01`{{execute}}

Consul is configured to look for the `dashboard-service` on port `9002`. You can see the configuration by looking at the configuration file at `/etc/consul.d/dashboard.json`.

`cat /etc/consul.d/dashboard.json`{{execute}}

Now start the service, specifying `PORT` as an environment variable.

`PORT=9002 dashboard-service`{{execute}}

You can view the demo dashboard application at this URL:

- [Dashboard Application](https://[[HOST_SUBDOMAIN]]-9002-[[KATACODA_HOST]].environments.katacoda.com/)

<img src="https://s3-us-west-1.amazonaws.com/education-yh/consul-connect/images/2-2-dashboard.png" alt="Demo Dashboard" title="Demo Dashboard">

The front-end demo dashboard has been hard-coded to look for the `counting` service on `localhost:9001` which is being provided by the Consul Connect proxy. It is reading the backend counting service and displays the number. Consul Connect is being used to proxy communication between the two services.
