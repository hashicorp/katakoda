Next, verify RPC traffic is unencrypted.

### Log server traffic

Output `tcpdump` to a file so that you can search for specific RPC traffic.

`tcpdump -an portrange 8300-8700 -A > /tmp/tcpdump.log`{{execute interrupt T1}}

Generate some Consul traffic using the CLI. This command will execute in **Terminal 2**.

`kubectl exec $(kubectl get pods -l component=client -o jsonpath='{.items[0].metadata.name}') -- consul catalog services`{{execute T2}}

### View the log file

From **Terminal 1** search the log file for the CLI operation.

`grep 'ListServices' /tmp/tcpdump.log`{{execute interrupt T1}}

The RPC call is in cleartext. This proves that RPC traffic
is not encrypted.

```plaintext
....A...Seq..ServiceMethod.Catalog.ListServices..AllowStale..Datacenter.dc1.Filter..MaxAge..MaxQueryTime..MaxStaleDuration..MinQueryIndex..MustRevalidate..NodeMetaFilters..RequireConsistent..Source..Datacenter..Ip..Node..Segment..StaleIfError..Token..UseCache.
```
