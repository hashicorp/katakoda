
Issue the following command, which will, in a separate terminal, forward the Grafana UI to port 3000 on the development host.

`export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}") && kubectl --namespace default port-forward $POD_NAME 3000 --address 0.0.0.0`{{execute T3}}

You will receive the following output.

```plaintext
Forwarding from 127.0.0.1:3000 -> 3000
Forwarding from [::1]:3000 -> 3000
```

## Login and import a dashboard

Now, open the Grafana UI tab next to the Terminal tab in the Katacoda environment. This will launch a new browser tab. Login with
username `admin` and password `password`. Once you
have logged into the Grafana UI, hover over the dashboards
icon (four squares in the left hand menu) and then click
the "Manage" option.

This will take you to a page that gives you some choices
about how to upload Grafana dashboards. Click the "Import"
button on the right hand side of the screen.

Open the file called `grafana/hashicups-dashboard.json`{{open}}
and copy the contents into the JSON window of the Grafana UI. **Note**,
this is an 862 line file, and you need to make sure you copy and paste all of it.
Click through the rest of the options, and you will end up with
a dashboard that shows your current cluster metrics.

Notice that once you started the traffic simulation deployment,
Prometheus started to log active connections, heap allocation,
cluster state, and a few other base metrics. Envoy exposes a
huge number of metrics. Which metrics are important to monitor
will depend on your application. For this tutorial we have
preconfigured a Grafana dashboard with a handful
of basic metrics, but you should systematically consider what others
you will need to collect as you move from testing into production.



