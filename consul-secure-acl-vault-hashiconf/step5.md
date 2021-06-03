You will now apply the token to the other two servers.

### Apply token to server-1 node

First create a new token for the `server-1` node:

`vault read consul/creds/consul-server-role \
  -format=json | tee ./assets/secrets/acl-vault-consul_server-1.json`{{execute T1}}

`export CONSUL_SERVER_TOKEN=$(cat ./assets/secrets/acl-vault-consul_server-1.json | jq -r ".data.token")`{{execute T1}}

Then setup your environment to reach the correct node:

`export SERVER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' server-1)`{{execute T1}}

`export CONSUL_HTTP_ADDR="https://${SERVER_IP}:443"`{{execute T1}}

Finally, apply the token to the Consul agent:

`consul acl set-agent-token agent $CONSUL_SERVER_TOKEN`{{execute T1}}

### Apply token to server-2 node

Same steps can be used to create a new token and apply it to the `server-2` node.

First create a new token for the `server-2` node:

`vault read consul/creds/consul-server-role \
  -format=json | tee ./assets/secrets/acl-vault-consul_server-2.json`{{execute T1}}

`export CONSUL_SERVER_TOKEN=$(cat ./assets/secrets/acl-vault-consul_server-2.json | jq -r ".data.token")`{{execute T1}}

Then setup your environment to reach the correct node:

`export SERVER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' server-2)`{{execute T1}}

`export CONSUL_HTTP_ADDR="https://${SERVER_IP}:443"`{{execute T1}}

Finally, apply the token to the Consul agent:

`consul acl set-agent-token agent $CONSUL_SERVER_TOKEN`{{execute T1}}

### Verify configuration from Consul logs

Once the token is applied you can check once more the Consul logs and verify 
that the warning lines are not being logged anymore.

`cat ./logs/consul-server-1-*`{{execute T1}}

```
...
[INFO]  agent: Updated agent's ACL token: token=agent
[INFO]  agent: Synced node info
...
```