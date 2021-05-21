Nomad uses the Serf protocol to communicate the members of a Nomad cluster and
their health to one another through gossip. Initially, this traffic is
unencrypted. This can allow other nodes to observe gossip messages, to send
their own gossip messages, and to join the cluster.

Encrypting the Serf protocol traffic helps to ensure that only the expected
nodes can be members of your cluster. Gossip encryption also helps to prevent
accidental federation of Nomad clusters when using the Consul auto-join feature.

You can observe this unencrypted traffic by running `tcpdump` to
capture UDP traffic on the Serf port-4648.

`tcpdump 'udp port 4648' -A`{{execute}}

If you watch long enough, you will see traffic that shows interesting
elements in the traffic like the member's node name.

```screenshot
13:15:19.678930 IP 192.168.1.11.4648 > 192.168.1.10.4648: UDP, length 152
E.....@.@..4.......
.(.(.......Payload......Adjustment...EA4..V.Error.?...^%.^.Height.?....[...Vec..>.o......?...R.[[.?.6...t..?..&..{..?.....M..?.:..xvJ.. ..J.........a)..SeqNo..
13:15:19.688751 IP 192.168.1.11.4648 > 192.168.1.13.4648: UDP, length 31
E..;Z.@.@.\c.........(.(.'.....Node.server3.global.SeqNo...
13:15:19.689052 IP 192.168.1.13.4648 > 192.168.1.11.4648: UDP, length 152
E....o@.@..`.........(.(.......Payload......Adjustment....C.A...Error.?.....|u.Height.?.b...1u.Vec..>....l...?...f....?)        M.....?*K......?...I<...?..+V.wo...8......... .x...SeqNo...
13:15:24.676059 IP 192.168.1.10.1024 > 192.168.1.11.4648: UDP, length 31
E..;.e@.@......
.......(.'.....Node.server1.global.SeqNo...
```
<!-- vale HashiCorp.TooWordy = NO -->
Notice items like “Payload”, “Adjustment”, and “Node” are human-readable.
<!-- vale HashiCorp.TooWordy = YES -->

Press `Ctrl-C` to exit tcpdump and return to the shell.
