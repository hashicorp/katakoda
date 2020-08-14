
In a third terminal, forward the Grafana UI to port 3000 with the following command.

`export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}") && kubectl --namespace default port-forward $POD_NAME 3000 --address 0.0.0.0`{{execute T3}}

You will receive the following output.

```plaintext
Forwarding from 127.0.0.1:3000 -> 3000
Forwarding from [::1]:3000 -> 3000
```

Now, open the Grafana UI tab next to the Terminal tab in the Katacoda environment. This will launch a new browser tab. Login with
username `admin` and password `password`. Once you
have logged into the Grafana UI, hover over the dashboards
icon (four squares in the left hand menu) and then click
the "Manage" option.

This will take you to a page that gives you some choices
about how to upload Grafana dashboards. Click the "Import"
button on the right hand side of the screen.

Open the file called `grafana/hashicups-dashboard.json`{{open}}
and copy the contents into the JSON window of the Grafana UI.
Click through the rest of the options, and you will end up with
a dashboard that shows your current cluster metrics.
