Next, prove that gossip/RPC traffic is encrypted.

### Capture server traffic

First, start a server shell session.
This will execute in **Terminal 2**.

`kubectl exec -it consul-server-0 -- /bin/sh`{{execute T2}}

Since the containers were recycled during the upgrade, you
need to add tcp dump again.

`apk update && apk add tcpdump`{{execute T2}}

Start `tcpdump` and observe the traffic.

`tcpdump -an portrange 8300-8700 -A`{{execute T2}}

Notice that, unlike before, none of the traffic is readable. This
proves that gossip traffic is encrypted.

Output `tcpdump` to a file so that you can test for cleartext RPC traffic.

`tcpdump -an portrange 8300-8700 -A > /tmp/tcpdump.log`{{execute interrupt T2}}

From a client agent in **Terminal 1**, try to list Consul services.

`kubectl exec $(kubectl get pods -l component=client -o jsonpath='{.items[0].metadata.name}') -- consul catalog services -token $(kubectl get secrets/consul-bootstrap-acl-token --template={{.data.token}} | base64 -d)`{{execute interrupt T1}}

Finally, switch back to **Terminal 2** and grep the server log for RPC entries

`grep 'ServiceMethod' /tmp/tcpdump.log`{{execute interrupt T2}}

No rows were found this time. This proves that RPC traffic is encrypted.
