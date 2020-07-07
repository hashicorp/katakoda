Next, start a second terminal. You'll start the frontend service, `dashboard-service`, on port `9002`. It will not yet connect to the `counting` service, you will do that in another step.

Click the **+** button in the tab bar and select **Open New Terminal**.

![New Terminal](./assets/images/ops-another-terminal.png)

The service definition instructs Consul to look for the `dashboard-service` on port `9002`. You can inspect the service definition by looking at the configuration file at `/etc/consul.d/dashboard.json`.

`cat /etc/consul.d/dashboard.json`{{execute}}

Now start the service, specifying `PORT` as an environment variable and `COUNTING_SERVICE_URL`. In another step, you will run the sidecar proxy on `localhost:9001`, so specify it here for future use.

`PORT=9002 COUNTING_SERVICE_URL=http://localhost:9001 dashboard-service`{{execute}}

You can view the demo dashboard application at this URL. It should show an error since we have not yet started the proxy:

- [Dashboard Application](https://[[HOST_SUBDOMAIN]]-9002-[[KATACODA_HOST]].environments.katacoda.com/)

<img src="https://hashicorp-education.s3-us-west-2.amazonaws.com/katacoda/consul-connect/images/3-3-dashboard-unreachable.png" alt="Demo dashboard cannot reach the counting service" title="Demo dashboard cannot reach the counting service">

In the next step, you'll restore the connection between the services.
