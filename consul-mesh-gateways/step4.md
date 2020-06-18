
You can verify federation for your two Consul datacenter using the `consul members` command:

`kubectl exec statefulset/consul-server -- consul members -wan`{{execute}}

The output should show servers from both datacenters:

```
Node                 Address          Status  Type    Build     Protocol  DC   Segment
consul-server-0.dc1  10.42.0.13:8302  alive   server  1.8.0rc1  2         dc1  <all>
consul-server-0.dc2  10.42.0.12:8302  alive   server  1.8.0rc1  2         dc2  <all>
```

If the second datacenter is still starting you could receive the following output until the server is not up and running:

```
Error from server (BadRequest): pod consul-server-0 does not have a host assigned
```