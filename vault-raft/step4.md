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

<br />

## Recover data from a Snapshot

If the data was lost due to unexpected event, you can recover the Vault data from the snapshot.

```
vault operator raft snapshot restore BACKUP-1.snap
```{{execute T2}}

You should be able to read the secrets at `secret/credentials` again.

```
vault kv get secret/credentials
```{{execute T2}}
