Verify the gossip encryption is enabled by performing the same tcpdump command
you used in the beginning of this scenario.

`tcpdump 'udp port 4648' -A`{{execute}}

Observe the traffic; note that cleartext no longer appears in the output.
