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

#### CPU usage

Check out the **cpu.usage.guest** metric

1. Scroll to the metrics under **cpu.usage** and observe the updates there.
1. Click **user** under **cpu.usage**.

### Dashboard

To optionally save a dashboard of all currently selected metrics, follow these steps.

1. Select **Search & Reporting**.
1. Select **Analytics**.
1. In the navigation at left click **vault** to expand the Vault metrics.
1. Scroll down to the bottom of the list.
1. Click **token**.
1. Click **create**.
1. Click **count**.
1. In the **Analysis** section click the drop-down under **Aggregation** and select **Sum**.
1. Click **Chart Settings**.
1. Select **Column**.

You should observe a graph with a token creation count.

With one chart ready, create another for the token creation mean duration.

1. In the left column under **Metrics** and **token** click **create**.
1. Click **mean**.
1. Click **Chart Settings**.
1. Select **Column**.

You should observe a graph with the mean token creation time.

Next, create another graph for the CPU usage for user processes.

1. In the left column under **Metrics** scroll to the top of the list.
1. Click **cpu.usage**.
1. Click **user**.
1. Click **Chart Settings**.
1. Select **Area**.

You should observe a graph of CPU usage by user processes.

Finally, create another graph for allocated bytes of memory to the Vault process.

1. In the left column under **Metrics** scroll down to **vault**.
1. Click **runtime**.
1. Click **alloc_bytes.value**.
1. Click **Chart Settings**.
1. Select **Area**.

You should observe a graph of allocated memory in bytes.

With 4 graphs ready, follow these steps to create a dashboard based on them.

1. Click the ellipse button in the upper right area of the middle pane as shown.
1. Click **Save all charts to a dashboard**.
1. Complete the **Save All To Dashboard** dialog.
1. For **Dashboard Title**, enter `Basic Vault Token Metrics`.
1. For **Dashboard Description**, enter some `Some basic Vault token metrics. and related system metrics in an example dashboard`.
1. Click **Save**.
1. You should observe a **Your Dashboard Has Been Created** dialog.
1. Click **View Dashboard**.

Now, you can edit the dashboard further to arrange it.

1. Click **Edit**.
1. Drag the individual graphs to arrange them; in this example they are positioned 2 by 2.
1. When the graphs are positioned, click **Save**.

Here is a screenshot of the final example dashboard.

This completes the metrics analysis and dashboard creation example along with the online tutorial itself.

Click **Continue** to finish.
