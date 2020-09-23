Once the agent configuration is created and thee certificates are distributed, you can start Consul.

First create Consul data directory

`mkdir -p /opt/consul/data`{{execute T1}}

`consul agent \
     -config-file server.json \
     -config-file server-tls.json \
     -advertise '{{ GetInterfaceIP "ens3" }}' \
     -data-dir=/opt/consul/data`{{execute T1}}

The output will indicate that TLS encryption is now enabled:

```
...
==> Starting Consul agent...
           Version: '1.8.3'
           Node ID: 'db8dd611-e833-e50e-3a5b-fc21fd63c348'
         Node name: 'server1'
        Datacenter: 'dc1' (Segment: '<all>')
            Server: true (Bootstrap: true)
       Client Addr: [127.0.0.1] (HTTP: 8500, HTTPS: 8501, gRPC: -1, DNS: 8600)
      Cluster Addr: 172.17.0.32 (LAN: 8301, WAN: 8302)
           Encrypt: Gossip: false, TLS-Outgoing: true, TLS-Incoming: true, Auto-Encrypt-TLS: true

==> Log data will now stream in as it occurs:
...
```

At this point, you have a Consul server with TLS encryption configured.

When you created the certificate you used as a parameter `ttl="24h"` meaning that this certificate will be valid only for 24 hours before expiring.

Deciding the right trade-off for certificate lifespan is always a compromise between security and agility. A possible third way that does not require you to lower your security is to use consul-template to automate certificate renewal for Consul when the TTL is expired.




