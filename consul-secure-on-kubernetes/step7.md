### Capture server traffic

Now that you have proven that ACLs are enabled, and that TLS verification is being enforced,
you will prove that gossip/RPC traffic is encrypted. First, start a server shell session.
This will execute in **Terminal 2**.

`kubectl exec -it consul-server-0 -- /bin/sh`{{execute T2}}

Next, since the containers were recycled during the helm upgrade, you will
have to add tcp dump again.

`apk update && apk add tcpdump`{{execute T2}}

Next, start `tcpdump` and observe the gossip traffic.

`tcpdump -an portrange 8300-8700 -A`{{execute T2}}

Notice that, unlike before, none of the traffic is human readable. This
proves that gossip traffic is now encrypted.

Next, output `tcpdump` to a file so that you can test for cleartext RPC traffic.

`tcpdump -an portrange 8300-8700 -A > /tmp/tcpdump.log`{{execute interrupt T2}}

Next, from a client agent in a different terminal, try to list Consul services with the Consul CLI.
This will execute in **Terminal 1**

`kubectl exec $(kubectl get pods -l component=client -o jsonpath='{.items[0].metadata.name}') -- consul catalog services -token $(kubectl get secrets/consul-bootstrap-acl-token --template={{.data.token}} | base64 -d)`{{execute interrupt T1}}

Finally, switch back to server in **Terminal 2**, stop tcpdump, and grep log for entry

`grep 'ServiceMethod' /tmp/tcpdump.log`{{execute interrupt T2}}

Notice that no rows were found this time. This proves that RPC traffic is now encrypted.
