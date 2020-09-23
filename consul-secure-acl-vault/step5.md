You can verify that the Consul server started correctly by checking the logs.

`cat /opt/consul/logs/consul.log`{{execute T1}}

In the logs you should get some warning lines similar to the following:

```
[WARN]  agent: Coordinate update blocked by ACLs: accessorID=00000000-0000-0000-0000-000000000002
[WARN]  agent: Node info update blocked by ACLs: node=6e24f8cd-33b5-645a-a2b3-b332e59e9f84 accessorID=00000000-0000-0000-0000-000000000002
```

These warnings signal that Consul started properly but it cannot communicate with the rest of the datacenter because of ACL restrictions.

### Create a token for the server node

Next, create a Consul token using the existing Vault token:

`vault read consul/creds/consul-server-role | tee consul.server`{{execute T1}}

Example output:

```
Key                Value
---                -----
lease_id           consul/creds/consul-server-role/bHDVG24vCO8BJ90ONjxrbKP6
lease_duration     768h
lease_renewable    true
accessor           2b9bb86a-d632-ea28-3890-7d1e0690ff57
local              false
token              5ea5eadc-807d-68c2-e47f-a1ac37e906b7
```

`export CONSUL_SERVER_ACCESSOR=$(cat consul.server  | grep accessor  | awk '{print $2}')`{{execute T1}}

Verify that the token is created correctly in Consul by
looking it up by its accessor:

`consul acl token read -id ${CONSUL_SERVER_ACCESSOR}`{{execute T1}}

```
AccessorID:       2b9bb86a-d632-ea28-3890-7d1e0690ff57
SecretID:         5ea5eadc-807d-68c2-e47f-a1ac37e906b7
Description:      Vault consul-server-role token 1598547759570180867
Local:            false
Create Time:      2020-08-27 17:02:39.572006543 +0000 UTC
Policies:
   6fa2c574-6951-51db-310a-672e328f2aba - consul-servers
```

Any user or process with access to Vault can now create
short lived Consul tokens in order to carry out operations,
thus centralizing the access to Consul tokens.

<div style="background-color:#eff5ff; color:#416f8c; border:1px solid #d0e0ff; padding:1em; border-radius:3px; margin:24px 0;">
  <p><strong>Info: </strong>

The way Vault and Consul refer to tokens in the command output is slightly different. The following table expresses the relations between the two outputs:
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

`export CONSUL_SERVER_TOKEN=$(cat consul.server  | grep token  | awk '{print $2}')`{{execute T1}}

Finally, you can apply the token to the server as its `agent` token.

`consul acl set-agent-token agent $(cat consul.server  | grep token  | awk '{print $2}')`{{execute T1}}

You should receive the following output:

```plaintext
ACL token "agent" set successfully
```

Once the token is applied you can check once more the Consul logs and verify that the warning lines are not being logged anymore.

`cat /opt/consul/logs/consul.log`{{execute T1}}

```
...
[INFO]  agent: Updated agent's ACL token: token=agent
[INFO]  agent: Synced node info
...
```
