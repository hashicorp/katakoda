The configuration process for clients is the same as the servers. 

### Configure Consul client

This lab comes with a prepared Consul client configuration.

Open `client.json`{{open}} in the editor to review the values required for a minimal client config with TLS encryption enabled.

In this lab, you are going to use the `auto_encrypt` functionality of Consul that will automatically generate and distribute certificates for the client agents once the datacenter is configured.

You will still need to refer to the CA certificate `consul-agent-ca.pem` to validate requests.

### Distribute configuration and certificate to the client

This lab uses a Docker volume, called `client_config` to help you distribute the files to your client node.

Copy the required files for the Consul client configuration into the volume.

`docker cp ./client.json volumes:/client/client.json`{{execute T3}}

`docker cp ./consul-agent-ca.pem volumes:/client/consul-agent-ca.pem`{{execute T3}}

### Retrieve Server IP to join the datacenter

`export CONSUL_HTTP_ADDR=$(docker exec server consul members | grep server-1 | awk '{print $2}' | sed 's/:.*//g')`{{execute T3}}

#### Start Consul client with the configuration file

Finally start the Consul client.

`docker run \
    -d \
    -v client_config:/etc/consul.d \
    --name=client \
    consul agent \
     -node=client-1 \
     -join=${CONSUL_HTTP_ADDR} \
     -config-file=/etc/consul.d/client.json`{{execute T3}}


#### Confirm client started and joined the datacenter

You can verify the Consul client started correctly and joined the datacenter using the `consul members` command.

`docker exec server consul members`{{execute T2}}

Or you can click the [Consul UI](https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/ui/dc1/nodes) tab to be redirected to the Consul UI.