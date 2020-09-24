This labs comes with a pre-configured Consul server.

Open `server.hcl`{{open}} in the editor to review the
values required for a minimal server configuration with
gossip encryption enabled.

Notice that the configuration does not include a section for encryption.

```
encrypt = "<insert gossip encryption here>"
```

You will generate one using the previously saved output.

`echo "encrypt = \""$(cat encryption.key)"\"" > gossip_encryption.hcl`{{execute}}

### Copy configuration into config folder

We recommend using `/etc/consul.d` to store your Consul configuration.

Copy the configuration files created into that folder:

```
mkdir -p /etc/consul.d
cp server.hcl gossip_encryption.hcl /etc/consul.d/
```{{execute}}


## Start Consul

Next, create the data directory for Consul as configured in the `server.hcl` file.

```
mkdir -p /opt/consul/data
mkdir -p /opt/consul/logs
```{{execute}}

Finally, start Consul.

`nohup sh -c "consul agent \
  -config-dir /etc/consul.d >/opt/consul/logs/consul.log 2>&1" > /opt/consul/logs/nohup_consul.log &`{{execute}}

<!--
`nohup sh -c "consul agent \
  -config-file server.hcl \
  -config-file gossip_encryption.hcl \
  -advertise '{{ GetInterfaceIP \"ens3\" }}' /opt/consul/logs/consul.log 2>&1" > /opt/consul/logs/nohup_consul.log &`{{execute}}
-->

If the configuration was successful, you will get an
indication in the output that gossip encryption is now enabled:

`cat /opt/consul/logs/consul.log`{{execute}}

```
==> Starting Consul agent...
           Version: '1.8.3'
           Node ID: '7ebe9143-a085-7a37-33dc-23db6cd39a80'
         Node name: 'server1'
        Datacenter: 'dc1' (Segment: '<all>')
            Server: true (Bootstrap: false)
       Client Addr: [0.0.0.0] (HTTP: 8500, HTTPS: -1, gRPC: -1, DNS: 8600)
      Cluster Addr: 172.17.0.33 (LAN: 8301, WAN: 8302)
           Encrypt: Gossip: true, TLS-Outgoing: false, TLS-Incoming: false, Auto-Encrypt-TLS: false
```
