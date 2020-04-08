Click the **+** next to the opened Terminal, and select **Open New Terminal** to start fifth terminal (**Terminal 5**).

![](https://education-yh.s3-us-west-2.amazonaws.com/screenshots/ops-another-terminal-2.png)


Open the `node3` server configuration file, `config-node3.hcl`{{open}}.

```
storage "raft" {
  path    = "/home/scrapbook/tutorial/raft-node3/"
  node_id = "node3"
}

listener "tcp" {
  address = "127.0.0.1:3200"
  cluster_address = "127.0.0.1:3201"
  tls_disable = true
}

disable_mlock = true
api_addr = "http://127.0.0.1:3200"
cluster_addr = "http://127.0.0.1:3201"
```

Notice that the `node_id` is set to `node3` and this server will listen to port **`3200`**.

Execute the following command to start `node3`:

```
mkdir raft-node3
vault server -config=config-node3.hcl
```{{execute T5}}

```
==> Vault server configuration:

             Api Address: http://127.0.0.1:3200
                     Cgo: disabled
         Cluster Address: https://127.0.0.1:3201
              Listener 1: tcp (addr: "127.0.0.1:3200", cluster address: "127.0.0.1:3201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: info
                   Mlock: supported: true, enabled: false
           Recovery Mode: false
                 Storage: raft (HA available)
                 Version: Vault v1.4.0

==> Vault server started! Log data will stream in below:
```

You can verify that the **Api Address** is `http://127.0.0.1:3200`.  

<br />

## Join the Cluster

Click the **+** next to the opened Terminal, and select **Open New Terminal** to start sixth terminal (**Terminal 6**).

![](https://education-yh.s3-us-west-2.amazonaws.com/screenshots/ops-another-terminal-2.png)

In **Terminal 6**, set the VAULT_ADDR to `http://127.0.0.1:3200`.

```
export VAULT_ADDR='http://127.0.0.1:3200'
```{{execute T6}}

Execute the `vault operator raft join` command to join the cluster.

```
vault operator raft join http://127.0.0.1:8200
```{{execute T6}}

Where `http://127.0.0.1:8200` is the API address of `node1`.

```
Key       Value
---       -----
Joined    true
```

Proceed to unseal the `node3` server.

```
vault operator unseal $(grep 'Key 1:' key.txt | awk '{print $NF}')
```{{execute T6}}

Once Vault is unsealed, you can login using the root token.

```
vault login $(grep 'Initial Root Token:' key.txt | awk '{print $NF}')
```{{execute T6}}

Check the Raft cluster configuration.

```
vault operator raft list-peers
```{{execute T6}}

```
Node     Address           State       Voter
----     -------           -----       -----
node1    127.0.0.1:8201    leader      true
node2    127.0.0.1:2201    follower    true
node3    127.0.0.1:3201    follower    true
```

You should see `node1`, `node2` and `node3` listed.


In **Terminal 5**, you will find the following entries in the server log:

```
...
[INFO]  storage.raft: Initial configuration (index=1): [{Suffrage:Voter ID:node1 Address:127.0.0.1:8201} {Suffrage:Voter ID:node2 Address:127.0.0.1:2201} {Suffrage:Voter ID:node3 Address:127.0.0.1:3201}]
[INFO]  storage.raft: Node at 127.0.0.1:3201 [Follower] entering Follower state (Leader: "")
...
[INFO]  core: vault is unsealed
[INFO]  core: entering standby mode
```

Next, learn about taking a data backup.
