Consul uses Access Control Lists (ACLs) to secure access to the UI, API, CLI,
service registration, and agent communications.

Open `server.hcl`{{open}} in the editor to inspect values required
for a minimal configuration with the ACL system enabled.

```
...
acl = {
  enabled = true
  default_policy = "deny"
  enable_token_persistence = true
}
...
```

In this lab, you will set the "default-deny" policy, which
denies all operations by default. All operations will be evaluated
against their token, and only operations granted by policy associated
with the token will be allowed.

By enabling token persistence, tokens will be persisted to disk and
reloaded when an agent restarts.

### Copy configuration into config folder

We recommend using `/etc/consul.d` to store your Consul configuration.

Copy the configuration files created into that folder:

`cp server.hcl /etc/consul.d/`{{execute}}

### Start Consul server

Next, create the data directory for Consul as configured in the `server.hcl` file.

`mkdir -p /opt/consul/data`{{execute}}

`mkdir -p /opt/consul/logs`{{execute}}

Finally, start Consul.

`nohup sh -c "consul agent \
  -config-dir /etc/consul.d >/opt/consul/logs/consul.log 2>&1" > /opt/consul/logs/nohup_consul.log &`{{execute}}

Once configuration is distributed on the agents, start the Consul server.

### Check the server logs

Verify the Consul server started correctly by checking the logs.

`cat /opt/consul/logs/consul.log`{{execute T1}}

You should get a log message like the following when ACLs are enabled:

`agent.server: initializing acls`

Alternatively, you can visit the [Consul UI](https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/ui) tab to launch the Consul UI.

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px;">
  <p><strong>Warning: </strong>
  Once ACLs are enabled, the results available in the UI include only those authorized for all unauthenticated (anonymous) clients. At this time, your first inspection of the UI will show only empty tabs (no services, nor nodes). You will enter a token to access that info from the UI later in this lab.
</p></div>

First, configure your environment to be able to interact with the Consul agent.

In this hands-on lab, the Consul process is listening to port `8500` of the local
machine. You should be able to interact with it using `localhost` address.

`export CONSUL_HTTP_ADDR=localhost:8500`{{execute T1}}

### Bootstrap the ACL system

Bootstrap the ACL system to start using tokens.

Issue the following command to bootstrap the ACL system, generate your first token,
and capture the output into the `consul.bootstrap` file.

`consul acl bootstrap | tee consul.bootstrap`{{execute T1}}

If you receive an error saying "The ACL system is currently in legacy mode.", this
indicates that the Consul service is still starting. Wait a few seconds and try the
command again.

Example output:

```
$ consul acl bootstrap | tee consul.bootstrap
AccessorID:       e57b446b-2da0-bce2-f01c-6c0134d8e19b
SecretID:         bba19e7c-9f47-2b08-f0ea-e1bca43ba9c5
Description:      Bootstrap Token (Global Management)
Local:            false
Create Time:      2020-02-20 17:01:13.105174927 +0000 UTC
Policies:
   00000000-0000-0000-0000-000000000001 - global-management
```

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px;">
  <p><strong>Warning: </strong>
  In this hands-on lab, you are redirecting the output of the `consul acl bootstrap` command to a file to simplify operations in the next steps. In a real-life scenario, you should ensure the bootstrap token is stored securely. If it is compromised, the ACL system can be abused.
</p></div>

Once ACLs have been bootstrapped, you can use the bootstrap token
to complete the configuration.

If the token is not set in the CONSUL_HTTP_TOKEN environment variable,
or passed as a a command line option, you will not be able to perform
operations with the Consul CLI, or you will be presented only with a subset
of results.

`consul members`{{execute T1}}

The output for the command seems to show an empty datacenter.

### Configure the token

You can set the token for the command using the `CONSUL_HTTP_TOKEN`
environment variable.

`export CONSUL_HTTP_TOKEN=$(cat consul.bootstrap  | grep SecretID  | awk '{print $2}')`{{execute T1}}

Now, try again to retrieve the list of members from Consul.

`consul members`{{execute T1}}

This time the output will show the server node.

```plaintext
$ consul members
Node      Address          Status  Type    Build  Protocol  DC   Segment
server-1  172.18.0.2:8301  alive   server  1.7.3  2         dc1  <all>
```

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px;">
  <p><strong>Production check: </strong>
  At this time you only have one token in Consul, the *bootstrap token*. While it is possible to use only this token for all the configuration in a testing or dev environment, this is not recommended in a production environment. This token should only be used for the initial ACL tuning and to create tokens with lower permissions.
</p></div>

You can now use the bootstrap token to create other ACL policies
for the rest of your datacenter.
