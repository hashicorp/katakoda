Now that you have generated some leases, secrets, and tokens, go back to your **Splunk Web** browser tab and explore those updated metrics.

First, click the **Refresh** button in the center section to provide you with the latest metrics you recently generated.. Note that due to interface scaling, it can appear abbreviated as **Ref...**.

### Core metrics

First, review the **core** metrics again to observe the values for the login_request metric.

1. Scroll to the metrics under **core** and **handle** to examine them again.
1. Click **count** under **login_request** to get a count of login requests handled.
1. You should observe a chart that has increased activity and now peaks at 50 requests- corresponding to your previous logins from step 4.

### Lease metrics

Next, check out the **expire** metrics, which correspond to leases.

1. Scroll to the metrics under **expire** and observe the updates there.
1. Click **num_leases.value** under **expire**.
1. You should observe a chart that peaks at 85 leases, corresponding to your previous activity from step 4.

Feel free to continue exploring the currently available metrics before proceeding. For those you are curious about, refer to the [Telemetry internals documentation](https://www.vaultproject.io/docs/internals/telemetry) to get more information.

Click **Continue** to proceed to step 4, where you will generate some new items in Vault and corresponding metrics.

### System metrics

The Telegraf agent samples and maintains metrics for OS level details like CPU and memory usage. Feel free to explore these and more.

**Memory usage**

Check out the **cpu.usage.guest** metric

1. Scroll to the metrics under **cpu.usage** and observe the updates there.
1. Click **guest** under **cpu.usage**.

### Dashboard

To save a dashboard of all currently selected metrics, follow these steps.

TODO: Dashboard steps will be added when finished in guide!
