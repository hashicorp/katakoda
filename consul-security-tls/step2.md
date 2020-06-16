
This labs comes with a prepared Consul server configuration.

Open `server.json`{{open}} in the editor to review the values required for a minimal server configuration with TLS encryption enabled.

Notice that the configuration includes options for the two files created in the previous step.

### Distribute configuration and certificates to the server

This labs uses a Docker volume, called `server_config` to help you distribute the files to your server node.

Copy the required files for the Consul server configuration into the volume.

`docker cp ./server.json volumes:/server/server.json`{{execute T2}}

`docker cp ./consul-agent-ca.pem volumes:/server/consul-agent-ca.pem`{{execute T2}}

`docker cp ./dc1-server-consul-0.pem volumes:/server/dc1-server-consul-0.pem`{{execute T2}}

`docker cp ./dc1-server-consul-0-key.pem volumes:/server/dc1-server-consul-0-key.pem`{{execute T2}}

#### Start Consul server with the configuration file

Finally start the Consul server.

`docker run \
    -d \
    -v server_config:/etc/consul.d \
    -p 8500:8500 \
    -p 8600:8600/udp \
    --name=server \
    consul agent -server -ui \
     -node=server-1 \
     -bootstrap-expect=1 \
     -client=0.0.0.0 \
     -config-file=/etc/consul.d/server.json`{{execute server}}


### Check server logs

You can verify the Consul server started correctly by checking the logs.

`docker logs server`{{execute T2}}

Or you can click the [Consul UI](https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/ui) tab to be redirected to the Consul UI.

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px;">
  <p><strong>Warning: </strong>
  The current configuration leaves the HTTP interface open for the UI so to permit you to access it without setting a client certificate for your browser. To complete configuration and prevent the UI to be accessed over HTTP you can add the following to your server configuration for a production environment:<br>
  ```
  "ports": {
    "http": -1,
    "https": 8501
  }
  ``` 
</p></div>
