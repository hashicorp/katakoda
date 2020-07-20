<style>
    pre.console {
        background-color: #383732 !important;
        font-family: "Fira Mono","DejaVu Sans Mono",Menlo,Consolas,"Liberation Mono",Monaco,"Lucida Console",monospace;
        color: white;
        overflow: auto;
        padding: 5px;
    }
</style>

### Deploy sample services

Now that the network communications have been secured and ACLs have been applied,
you will configure zero-trust networking using Consul intentions. Exit the terminal
running on the container.

`exit`{{execute interrupt T2}}

Run the following command to deploy a sample backend service to the cluster.

`kubectl apply -f server.yaml`{{execute T1}}

Now, deploy a downstream client.

`kubectl apply -f client.yaml`{{execute T1}}

Next, make sure all pods have a status of `Running` before proceeding to the next section.

`watch kubectl get pods`{{execute T1}}

### Configure intentions

With manageSystemACLs set to true, the Consul Helm chart will create a `deny all` intention by default.
Run the following command to validate that the `deny all` intention is enforced

`kubectl exec static-client static-client -- curl -s http://127.0.0.1:1234/ `{{execute interrupt T1}}

Observe that the command exits with a non-zero exit code.

<pre class="console">
Defaulting container name to static-client.
Use 'kubectl describe pod/static-client -n default' to see all of the containers in this pod.
command terminated with exit code 7
</pre>

Next, create an `allow` intention for client to server traffic.

`consul intention create -ca-file ca.pem -allow static-client static-server`{{execute T1}}

Finally, validate the intention allows traffic to from the client to the server.
If this fails, wait a few seconds for the intention to be applied, and try again.

`kubectl exec static-client static-client -- curl -s http://127.0.0.1:1234/ `{{execute T1}}

Notice the output now includes "hello world". This proves the intention is now allowing
traffic between the client and the server.

<pre class="console">
Defaulting container name to static-client.
Use 'kubectl describe pod/static-client -n default' to see all of the containers in this pod.
"hello world"
</pre>
