You can verify the Consul server started correctly by checking the logs.

`cat ./logs/consul-server-1-*`{{execute T1}}

In the logs you should get some warning lines similar to the following:

```
[WARN]  agent: Coordinate update blocked by ACLs: accessorID=00000000-0000-0000-0000-000000000002
[WARN]  agent: Node info update blocked by ACLs: node=6e24f8cd-33b5-645a-a2b3-b332e59e9f84 accessorID=00000000-0000-0000-0000-000000000002
```

These warnings signal that Consul started properly but it cannot communicate 
with the rest of the datacenter because of ACL restrictions.

### Create a token for the server node

Next, create a Consul token using the existing Vault token:

`vault read consul/creds/consul-server-role \
  -format=json | tee ./assets/secrets/acl-vault-consul_server.json`{{execute T1}}

Example output:

```
{
  "request_id": "b540feba-6d57-17f4-5ded-c7070ee02a46",
  "lease_id": "consul/creds/consul-server-role/nPjDLMwng5aWFXFzw02J1fY5",
  "lease_duration": 2764800,
  "renewable": true,
  "data": {
    "accessor": "90d594cd-1cf5-bd48-a968-8cb26cc10bcb",
    "local": false,
    "token": "b9487f69-d9c9-727e-f246-40f8dd47317d"
  },
  "warnings": null
}
```

Verify that the token is created correctly in Consul by
looking it up by its accessor.

First store the token's accessor ID into an environment variable:

`export CONSUL_SERVER_ACCESSOR=$( cat ./assets/secrets/acl-vault-consul_server.json | jq -r ".data.accessor")`{{execute T1}}

Then query Consul for a token with that accessor ID:

`consul acl token read -id ${CONSUL_SERVER_ACCESSOR}`{{execute T1}}

```
AccessorID:       90d594cd-1cf5-bd48-a968-8cb26cc10bcb
SecretID:         b9487f69-d9c9-727e-f246-40f8dd47317d
Description:      Vault consul-server-role token 1622564602570393827
Local:            false
Create Time:      2021-06-01 16:23:26.614088212 +0000 UTC
Policies:
   1c5a6748-dd49-8a8a-3a99-6f6b685fb642 - consul-servers
```

Any user or process with access to Vault can now obtain
short lived Consul tokens in order to carry out operations,
thus centralizing the access to Consul tokens.

<div style="background-color:#eff5ff; color:#416f8c; border:1px solid #d0e0ff; padding:1em; border-radius:3px; margin:24px 0;">
  <p><strong>Info: </strong>


The way Vault and Consul refer to tokens in the command output is slightly 
different. The following table expresses the relations between the two outputs:
<br/>

<table style="width:auto">
  <tr>
    <th>Consul</th>
    <th>Vault</th> 
    <th>Meaning</th>
  </tr>
  <tr>
    <td>`AccessorID`</td>
    <td>`accessor`</td>
    <td>The unique identifier for the token inside Consul and Vault.</td>
  </tr>
  <tr>
    <td>`SecretID`</td>
    <td>`token`</td>
    <td>The actual token to be used for configuration and operations.</td>
  </tr>
</table>

Using Consul secrets engine with Vault ensures that these values are kept consistent when the tokens are replicated to Consul.
</p></div>

### Apply token to Consul server

For this lab you saved the token inside the `consul.server` file.

You can retrieve it and store it in an environment variable.

`export CONSUL_SERVER_TOKEN=$(cat ./assets/secrets/acl-vault-consul_server.json | jq -r ".data.token")`{{execute T1}}

Finally, you can apply the token to the server as its `agent` token.

`consul acl set-agent-token agent $CONSUL_SERVER_TOKEN`{{execute T1}}

You should receive the following output:

```plaintext
ACL token "agent" set successfully
```