<style>
    pre.console {
        background-color: #383732 !important;
        font-family: "Fira Mono","DejaVu Sans Mono",Menlo,Consolas,"Liberation Mono",Monaco,"Lucida Console",monospace;
        color: white;
        padding: 5px;
    }
</style>

### Log server traffic

Next, output `tcpdump` to a file so that you can test for cleartext RPC traffic.

`tcpdump -an portrange 8300-8700 -A > /tmp/tcpdump.log`{{execute interrupt T1}}

Next, generate some Consul traffic using the CLI. This simulates a user setting a value that
may contain sensitive or secret information. This command will execute **Terminal 2**.

`kubectl exec $(kubectl get pods -l component=client -o jsonpath='{.items[0].metadata.name}') -- consul kv put password=1234`{{execute T2}}

### View the log file

Now, from **Terminal 1** you can search the log file for the CLI operation with the following command:

`grep 'ServiceMethod.KVS' /tmp/tcpdump.log`{{execute interrupt T1}}

You are able to see the Key-Value store entry in cleartext. This proves that RPC traffic
is not encrypted.

<pre class="console">
....Seqr.ServiceMethod.KVS.Apply..Datacenter.dc1.DirEnt..CreateIndex..Flags..Key.password=1234.LockIndex..ModifyIndex..Session..Value..Op.set.Token.
</pre>

Exit the server container running in **Terminal 1**.

`exit`{{execute T1}}
