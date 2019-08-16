Let's enable K/V secrets engine and create some test data.

> **NOTE:** You can execute the CLI commands from any of the node; however, the request will always be routed to the active server which is `node1`.  

```
vault secrets enable -path=secret kv-v2
vault kv put secret/credentials user_id="student" passcode="vaultrocks"
```{{execute T6}}

In **Terminal 1**, you will find the following entries in the server log:

```
[INFO]  core: successful mount: namespace= path=secret/ type=kv
```

However, you don't see this entry in either `node2` (**Terminal 3**) or `node3` (**Terminal 5**) server logs since they are standby nodes.


Verify that you can read the data.

```
vault kv get secret/credentials
```{{execute T2}}

<br>

## Take a snapshot

Execute the `vault operator snapshot save` command to capture the current Vault data.

```
vault operator raft snapshot save BACKUP-1.snap
```{{execute T2}}

Now, delete the entire data at `secret/credentials`.

```
vault kv metadata delete secret/credentials
```{{execute T2}}

Verify that the data is deleted.

```
vault kv get secret/credentials
vault kv list secret
```{{execute T2}}

No value found at this point.

<br />

## Recover data from a Snapshot

If the data was lost due to unexpected event, you can recover the Vault data from the snapshot.

```
vault operator raft snapshot restore BACKUP-1.snap
```{{execute T2}}

Return to the first **Terminal** to examine the `node1` server log.  You should see that the data is being restored.

```
...
[INFO]  core: successfully setup plugin catalog: plugin-directory=
[INFO]  core: successfully mounted backend: type=system path=sys/
[INFO]  core: successfully mounted backend: type=identity path=identity/
[INFO]  core: successfully mounted backend: type=kv path=secret/
[INFO]  core: successfully mounted backend: type=cubbyhole path=cubbyhole/
[INFO]  core: successfully enabled credential backend: type=token path=token/
[INFO]  core: restoring leases
[INFO]  rollback: starting rollback manager
[INFO]  identity: entities restored
[INFO]  identity: groups restored
[INFO]  expiration: lease restore complete
[INFO]  core: post-unseal setup complete
```

Now, you should be able to read the secrets at `secret/credentials` again.

```
vault kv get secret/credentials
```{{execute T2}}


<br>

## Leave the Cluster

If you ever need to remove a node from a cluster, invoke the following command.

```
vault operator raft remove-peer node3
```{{execute T2}}

Verify the Raft cluster configuration.

```
vault operator raft configuration -format=json
```{{execute T2}}

```
{
  ...
  "data": {
    "config": {
      "index": 51,
      "servers": [
        {
          "address": "127.0.0.1:8201",
          "leader": true,
          "node_id": "node1",
          "protocol_version": "3",
          "voter": true
        },
        {
          "address": "127.0.0.1:2201",
          "leader": false,
          "node_id": "node2",
          "protocol_version": "3",
          "voter": true
        }
      ]
    }
  },
  ...
```
