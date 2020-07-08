Now that your infrastructure is ready, you can access [Splunk Web](https://[[HOST_SUBDOMAIN]]-8000-[[KATACODA_HOST]].environments.katacoda.com) **in a separate browser tab** to examine the initial Vault telemetry metrics present there.

Sign in to Splunk Web with these credentials:

- Username: `admin`
- Password: `vtl-password`

Acknowledge the _Helping You Get More Value from Splunk Software_ dialog by clicking **Got it!**.

Acknowledge any _Important changes coming!_ dialog by clicking **Don't show me this again**.

You are now ready to explore the existing Vault telemetry metrics.

1. Click the **Search & Reporting** navigation tab.
1. Acknowledge any _Welcome, Administrator_ dialog by clicking **Skip**
1. Click the **Analytics** tab.
1. Click **Metrics** in the left navigation to expand the metrics tree.

You'll notice that there are plenty of system related metrics like **cpu.usage**, **disk**, **mem**, and so on.

1. Go ahead and click on **cpu.usage**
1. Click **user**
1. You should observe a small chart in the center panel that contains a graph of recent CPU usage activity

This metric, like the other system level metrics present, originates from the Telegraf agent itself.

Now, let's take a look at some of the Vault specific metrics, like the **runtime** metrics to confirm that there are indeed values present there as well.

First, check out metrics about vault process memory usage.

1. Scroll to the bottom of the metrics list.
1. Click **vault** to expand the Vault related metrics.
1. Click **runtime** to expand the runtime metrics.
1. Click **alloc_bytes.value**.
1. A line graph will appear that should contain an indication of the memory currently allocated to the vault process expressed in megabytes. It should show variations between 10 and 20 megabytes allocated to Vault.

Next, examine the metrics under **core**.

1. Click **core** to expand the core metrics.
1. Click the **handle** metrics to expand request handling metrics.
1. Click **login_request** to expand the available metric types related handling of login  requests.
1. Click **count** to get a count of login requests handled; you should observe a chart with just 1 entry corresponding to your previous login with the root token in step 2.

Finally, navigate to the **expire** metrics, which correspond to leases.

1. Click **expire** to expand the expiration metrics.
1. Click **num_leases.value**.
1. A chart with zero values appears; this is expected as no leases have yet been generated.

Feel free to continue exploring the currently available metrics before proceeding. For those you are curious about, refer to the [Telemetry internals documentation](https://www.vaultproject.io/docs/internals/telemetry) to get more information.

Click **Continue** to proceed to step 4, where you will generate new items in Vault and corresponding new metrics values to explore.
