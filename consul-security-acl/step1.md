
Consul uses Access Control Lists (ACLs) to secure the UI, API, CLI, service communications, and agent communications. When securing your datacenter you should configure the ACLs first.

Open `server.hcl`{{open}} in the editor to inspect values required for a minimal configuration with the ACL system enabled.

```
acl = {
  enabled = true
  default_policy = "deny"
  enable_token_persistence = true
}
```

In this lab, you will configure the "default-deny" policy, which denies all operations by default. All operations will be evaluated against their token, and only operations granted by policy associated with the token will be allowed.

By enabling token persistence, tokens will be persisted to disk and reloaded when an agent restarts.

#### Distribute configuration

This scenario uses a Docker volume, called `server_config` to help you distribute the configuration to your server.

`docker cp ./server.hcl volumes:/server/server.hcl`{{execute T1}}

### Start Consul server

Once configuration is distributed on the nodes, it is possible to start the Consul server.

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
     -config-file=/etc/consul.d/server.hcl`{{execute T1}}

### Check server logs

You can verify the Consul server started correctly by checking the logs.

`docker logs server`{{execute T1}}

You should get a log message like the following when ACLs are enabled:

`agent.server: initializing acls`

Alternatively you can visit the [Consul UI](https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/ui) tab to launch the Consul UI.

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px;">
  <p><strong>Warning: </strong>
  Once ACLs are enabled the results available in the UI include only those authorized for all unauthenticated (anonymous) clients. At this time, your first inspection of the UI will show only empty tabs (no services, nor nodes). You will enter a token to access that info from the UI later in this lab.
</p></div>