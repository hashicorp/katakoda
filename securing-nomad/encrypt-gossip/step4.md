You can verify encryption by performing the same tcpdump
command that you used in the beginning of this scenario

```
tcpdump 'udp port 4648' -A
```{{execute}}

Observe that the traffic. Note that cleartext no longer
appears in the output.
