Before updating the load balancing policy, you can check that the environment has five Consul agents, two backend services, and that the load balancing policy is the default `round_robin`.  

First, use `docker ps`:

`docker ps --format "{{.ID}}: {{.Names}}  \t {{.Ports}}"`{{execute}}

Example output:

```
8c49801f602d: ingress-gw    0.0.0.0:8080->8080/tcp, 0.0.0.0:8888->8888/tcp, 10000/tcp
90e49a8e39e4: backend-clone 10000/tcp
0f4b951627c0: backend-main  10000/tcp
d54059138370: client        10000/tcp
76bd086a2de4: server        0.0.0.0:8500->8500/tcp, 0.0.0.0:8600->8600/udp, 10000/tcp
```

The output shows five running containers each one running a Consul agent.

This can be also verified using `consul members` on one of the containers

`docker exec server consul members`{{execute}}

```
Node        Address          Status  Type    Build     Protocol  DC   Segment
server-1    172.18.0.2:8301  alive   server  1.9.0dev  2         dc1  <all>
client-1    172.18.0.3:8301  alive   client  1.9.0dev  2         dc1  <default>
ingress-gw  172.18.0.6:8301  alive   client  1.9.0dev  2         dc1  <default>
service-1   172.18.0.4:8301  alive   client  1.9.0dev  2         dc1  <default>
service-2   172.18.0.5:8301  alive   client  1.9.0dev  2         dc1  <default>
```

In this configuration you can verify the backend service is accessible from the client container using `curl`

`docker exec client curl -s localhost:9192`{{execute}}

Example output:

```
{
  "name": "main",
  "uri": "/",
  "type": "HTTP",
  "ip_addresses": [
    "172.18.0.4"
  ],
  "start_time": "2020-10-01T16:15:54.151406",
  "end_time": "2020-10-01T16:15:54.151885",
  "duration": "478.867µs",
  "body": "Hello World",
  "code": 200
}
```

## Default load balancing policy

By default Consul balances traffic across instances of the same service using the `round_robin` policy.

You can verify the balancing by issuing the `curl` command multiple times. 
