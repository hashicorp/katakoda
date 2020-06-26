-----
Wait until the initial setup completes before start.
-----

In this tutorial, you are going to create a highly available (HA) Vault cluster using the integrated storage backend as its persistent storage.

For the purpose of demonstration, you are going to run 3 Vault server instances each listens to a different port: **node1** listens to port `8200`, **node2** listens to port `2200` and **node3** listens to port `3200`.

![](./assets/raft-storage.png)


### Start Vault Server 1 (node1)

First review the server configuration file, `config-node1.hcl`{{open}}.

```
storage "raft" {
  path    = "/home/scrapbook/tutorial/raft-node1/"
  node_id = "node1"
}

listener "tcp" {
  address = "127.0.0.1:8200"
  cluster_address = "127.0.0.1:8201"
  tls_disable = true
}

disable_mlock = true
api_addr = "http://127.0.0.1:8200"
cluster_addr = "http://127.0.0.1:8201"
```

The `storage` stanza is set to use `raft` which is the integrated storage. The `path` specifies the filesystem path where the data gets stored. The `node_id` sets the identifier for this node in the cluster. In this case, the node ID is `node1`.


Enter the following command to start the `node1` Vault server.  

> Click on the command (`⮐`) will automatically copy it into the terminal and execute it.

```
mkdir raft-node1
vault server -config=config-node1.hcl
```{{execute T1}}


Scroll up the Terminal to locate the following output:

```
==> Vault server configuration:

             Api Address: http://127.0.0.1:8200
                     Cgo: disabled
         Cluster Address: https://127.0.0.1:8201
              Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "127.0.0.1:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: info
                   Mlock: supported: true, enabled: false
           Recovery Mode: false
                 Storage: raft (HA available)
                 Version: Vault v1.4.0

==> Vault server started! Log data will stream in below:
```

Now, you need to initialize and unseal the Vault server (`node1`).

<br />
## Initialize and Unseal node1

Click the **+** next to the opened Terminal, and select **Open New Terminal**.

![New Terminal](./assets/ops-another-terminal.png)

In the **Terminal 2**, set the `VAULT_ADDR` environment variable:

```
export VAULT_ADDR='http://127.0.0.1:8200'
```{{execute T2}}

Now, execute the `vault operator init` command to initialize the `node1`:

```
vault operator init -key-shares=1 -key-threshold=1 > key.txt
```{{execute T2}}

> **NOTE:** For the simplicity, setting the number of unseal keys to `1` as well as the key threshold, and storing the generated unseal key and initial root token in a local file named, `key.txt`{{open}}.


Execute the `vault operator unseal` command to enter unseal `node1`:

```
vault operator unseal $(grep 'Key 1:' key.txt | awk '{print $NF}')
```{{execute T2}}

```
Key                    Value
---                    -----
Seal Type              shamir
Initialized            true
Sealed                 false
Total Shares           1
Threshold              1
...
```

Return to the first **Terminal** and examine the server log.

Notice that right after `node1` was unsealed, it first goes into **standby** mode.

```
...
[INFO]  core: vault is unsealed
[INFO]  core: entering standby mode
[INFO]  storage.raft: Node at 127.0.0.1:8201 [Follower] entering Follower state (Leader: "")
...
```

Since `node1` is currently the only cluster member, it gets elected to be the **leader**.  

```
...
[WARN]  storage.raft: Heartbeat timeout from "" reached, starting election
[INFO]  storage.raft: Node at 127.0.0.1:8201 [Candidate] entering Candidate state in term 2
[INFO]  storage.raft: Election won. Tally: 1
[INFO]  storage.raft: Node at 127.0.0.1:8201 [Leader] entering Leader state
[INFO]  core: acquired lock, enabling active operation
[INFO]  core: post-unseal setup starting
...
[INFO]  core: post-unseal setup complete
```

Now, `node1` is ready!

<br />

Log into Vault using the **initial root token** (`key.txt`{{open}}):

```
vault login $(grep 'Initial Root Token:' key.txt | awk '{print $NF}')
```{{execute T2}}

Execute the following command to view the node1's Raft cluster configuration.

```
vault operator raft list-peers
```{{execute T2}}

```
Node     Address           State     Voter
----     -------           -----     -----
node1    127.0.0.1:8201    leader    true
```

At this point, `node1` is the only cluster member; therefore, it becomes the `leader` by default.
