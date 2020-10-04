<style type="text/css">
.lang-screenshot { -webkit-touch-callout: none; -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; }
</style>

Run the `consul acl set-agent-token agent` command with your recently created
Consul agent token. For the scenario, you can load it out of the file created
in the last step

```shell
export AGENT_TOKEN=$(awk '/SecretID/ {print $2}' ~/consul-agent.token)
consul acl set-agent-token agent ${AGENT_TOKEN}
```{{execute}}

**Example Output**

```screenshot
$ export AGENT_TOKEN=$(awk '/SecretID/ {print $2}' ~/consul-agent.token)
$ consul acl set-agent-token agent ${AGENT_TOKEN}
ACL token "agent" set successfully
```
