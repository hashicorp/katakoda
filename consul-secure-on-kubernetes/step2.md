### View server traffic

To verify that network traffic is in cleartext you will inspect it.
You should now have a container running named `consul-server-0`. Connect
to it with the following command:

`kubectl exec -it consul-server-0 -- /bin/sh`{{execute interrupt T1}}

The container images used by this hands-on lab are lightweight alpine images. They ship with
limited tools. Run the following commands to install `tcpdump`:

`apk update && apk add tcpdump`{{execute T1}}

Start `tcpdump` to view traffic to the server container.

`tcpdump -an portrange 8300-8700 -A`{{execute T1}}

Inspect the output and observe that the traffic is in cleartext.
Note the UDP operations. These entries are the gossip protocol at work.
This proves that gossip encryption is not enabled.

Next we’re going to show how RPC communication–how Consul makes API
calls between clients and servers–also is occurring in plaintext
