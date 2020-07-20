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

Next, generate some Consul traffic using the CLI. This command will execute **Terminal 2**.

`kubectl exec $(kubectl get pods -l component=client -o jsonpath='{.items[0].metadata.name}') -- consul catalog services`{{execute T2}}

### View the log file

Now, from **Terminal 1** you can search the log file for the CLI operation with the following command:

`grep 'ListServices' /tmp/tcpdump.log`{{execute interrupt T1}}

You are able to see the RPC call in cleartext. This proves that RPC traffic
is not encrypted.

<pre class="console">
....A...Seq..ServiceMethod.Catalog.ListServices..AllowStale..Datacenter.dc1.Filter..MaxAge..MaxQueryTime..MaxStaleDuration..MinQueryIndex..MustRevalidate..NodeMetaFilters..RequireConsistent..Source..Datacenter..Ip..Node..Segment..StaleIfError..Token..UseCache.
</pre>
