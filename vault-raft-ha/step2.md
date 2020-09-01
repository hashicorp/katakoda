Now, you wish add two more nodes and turn it into a 3-node cluster.

Click the **+** next to the opened Terminal, and select **Open New Terminal** to start third terminal (**Terminal 3**).

Open the `node2` server configuration file, `config-node2.hcl`{{open}}.

Notice that the `node_id` is set to `node2` and this server will listen to port **`8220`**.

Execute the following command to start `node2`:

```
mkdir raft-node2
vault server -config=config-node2.hcl
```{{execute T3}}

```
==> Vault server configuration:

              HA Storage: raft
             Api Address: http://127.0.0.1:8220
                     Cgo: disabled
         Cluster Address: https://127.0.0.1:8221
              Go Version: go1.14.4
              Listener 1: tcp (addr: "127.0.0.1:8220", cluster address: "127.0.0.1:8221", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: info
                   Mlock: supported: true, enabled: false
           Recovery Mode: false
                 Storage: file
                 Version: Vault v1.5.3

==> Vault server started! Log data will stream in below:
```

It shows **HA Storage** is `raft` and **Storage** is `file`.

<br />

## Join the raft luster

Click the **+** next to the opened Terminal, and select **Open New Terminal** to start fourth terminal (**Terminal 4**).


In **Terminal 4**, set the VAULT_ADDR to `http://127.0.0.1:8220`.

```
export VAULT_ADDR='http://127.0.0.1:8220'
```{{execute T4}}

Unseal `node2`.

```
vault operator unseal $(grep 'Key 1:' key.txt | awk '{print $NF}')
```{{execute T4}}

> Remember that the server is using the file storage backend to persist Vault data; therefore, the shamir's unseal keys, encryption key and the initial root token are created and persisted at `/home/scrapbook/tutorial/vault-storage-file` when you initialized vault_1.

Execute the `vault operator raft join` command to join `node2` to `node1` Raft cluster.

```
vault operator raft join
```{{execute T4}}

Check the `node2` server status again.

```
vault status
```{{execute T4}}

```
Key                    Value
---                    -----
Seal Type              shamir
Initialized            true
Sealed                 false
Total Shares           1
Threshold              1
Version                1.5.3
Cluster Name           vault-cluster-b0e1e848
Cluster ID             8c351a6a-e77a-7dcc-6a80-1f80cb62d4ff
HA Enabled             true
HA Cluster             https://127.0.0.1:8211
HA Mode                standby
Active Node Address    http://127.0.0.1:8210
```


Once Vault is unsealed, you can login using the root token.

```
vault login $(grep 'Initial Root Token:' key.txt | awk '{print $NF}')
```{{execute T4}}

Execute the following command to list the raft peer set.

```
vault operator raft list-peers
```{{execute T4}}

```
Node     Address           State       Voter
----     -------           -----       -----
node1    127.0.0.1:8201    leader      true
node2    127.0.0.1:2201    follower    true
```

You should see both `node1` and `node2` listed.

At this point, you have two-node cluster.  Let's continue and add `node3` to this cluster.
