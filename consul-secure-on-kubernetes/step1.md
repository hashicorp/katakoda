<style>
    pre.console {
        background-color: #383732 !important;
        font-family: "Fira Mono","DejaVu Sans Mono",Menlo,Consolas,"Liberation Mono",Monaco,"Lucida Console",monospace;
        color: white;
        overflow: auto;
        padding: 5px;
    }
</style>
### Download Helm repo

First, click the box below to run the following command and download the Helm repo:

`helm repo add hashicorp https://helm.releases.hashicorp.com`{{execute T1}}

### Review a basic config file

Review the `dc1.yaml`{{open}} file. For a complete reference of all possible configuration
options, review the official [documentation](https://www.consul.io/docs/k8s/helm).

### Apply the chart

Apply the chart using the following command. It will start the consul clients and servers
and provision a persistent disk. The install may take a minute or two to complete.

`helm install -f ./dc1.yaml katacoda hashicorp/consul --wait`{{execute T1}}

When the installation is complete, you should receive output similar to the following:

<pre class="console">
NAME: katacoda
LAST DEPLOYED: Wed Jul  8 15:56:47 2020

...omitted

  $ helm status katacoda
  $ helm get all katacoda
</pre>

### Verify installation

Verify that everything installs successfully by reviewing the status
of running pods using the following command:

`kubectl get pods`{{execute T1}}

Once all pods have a status of `Running`, as illustrated in the following output,
the installation is complete.

<pre class="console">
NAME                                                 READY   STATUS    RESTARTS   AGE
consul-7d4h2                                         1/1     Running   0          82s
consul-connect-injector-webhook-deployment           1/1     Running   0          94s
consul-server-0                                      1/1     Running   0          93s
</pre>