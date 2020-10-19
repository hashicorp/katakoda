You can check the environment using `docker ps`:

`docker ps --format "{{.Names}}\t\t{{.Ports}}"`{{execute T1}}

Example output:

```
ingress-gw      0.0.0.0:8080->8080/tcp, 0.0.0.0:8888->8888/tcp, 10000/tcp
web             0.0.0.0:9002->9002/tcp, 0.0.0.0:19002->19002/tcp, 10000/tcp
api             10000/tcp, 0.0.0.0:19001->19001/tcp
server          0.0.0.0:8500->8500/tcp, 0.0.0.0:8600->8600/udp, 10000/tcp
```

The output shows five running containers each one running a Consul agent.

## Operator node

The server port for Consul is been forwarded to the hosting node so you can use Consul without the need to login to a different node or to run a local agent in order to communicate with Consul. 

You can verify this using `consul members` on the terminal

`consul members`{{execute T1}}

```
Node        Address          Status  Type    Build     Protocol  DC   Segment
server-1    172.18.0.2:8301  alive   server  1.9.0dev  2         dc1  <all>
ingress-gw  172.18.0.5:8301  alive   client  1.9.0dev  2         dc1  <default>
service-1   172.18.0.3:8301  alive   client  1.9.0dev  2         dc1  <default>
service-2   172.18.0.4:8301  alive   client  1.9.0dev  2         dc1  <default>
```

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px; margin:24px 0;">
  <p><strong>Production note:</strong> This scenario runs a non-secure configuration for Consul for test purposes. In a production scenario you want to [secure Consul agent communication with TLS encryption](https://learn.hashicorp.com/tutorials/consul/tls-encryption-secure?in=consul/security-networking) to make sure your requests to the Consul datacenter are encrypted. You also want to [secure Consul with Access Control Lists (ACLs)](https://learn.hashicorp.com/tutorials/consul/access-control-setup-production?in=consul/security-networking) to fine tune permissions you can perform from external requests.

</p></div>

## DNS Configuration

The DNS for the hosting node has been configured to use Consul as primary DNS.

You can now leverage the Consul DNS directly inside the node:

`ping -c 3 api.service.consul`{{execute T1}}

```plaintext
PING api.service.consul (172.18.0.3) 56(84) bytes of data.
64 bytes from service-1.node.dc1.consul (172.18.0.3): icmp_seq=1 ttl=64 time=0.056 ms
64 bytes from service-1.node.dc1.consul (172.18.0.3): icmp_seq=2 ttl=64 time=0.079 ms
64 bytes from service-1.node.dc1.consul (172.18.0.3): icmp_seq=3 ttl=64 time=0.057 ms

--- api.service.consul ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2000ms
rtt min/avg/max/mdev = 0.056/0.064/0.079/0.010 ms
```

