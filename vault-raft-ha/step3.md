Click the **+** next to the opened Terminal, and select **Open New Terminal** to start a new terminal (**Terminal 5**).

Open the `node3` server configuration file, `config-node3.hcl`{{open}}.

```
ha_storage "raft" {
  path    = "/home/scrapbook/tutorial/raft-node3/"
  node_id = "node3"
}

storage "file" {
    path = "/home/scrapbook/tutorial/vault-storage-file"
}

listener "tcp" {
  address = "127.0.0.1:8230"
  cluster_address = "127.0.0.1:8231"
  tls_disable = true
}

disable_mlock = true
api_addr = "http://127.0.0.1:8230"
cluster_addr = "http://127.0.0.1:8231"
```

Notice that the `node_id` is set to `node3` and this server will listen to port **`8230`**.

Execute the following command to start `node3`:

```
mkdir raft-node3
vault server -config=config-node3.hcl
```{{execute T5}}


## Join the raft luster

Click the **+** next to the opened Terminal, and select **Open New Terminal** to start another terminal (**Terminal 6**).


In **Terminal 6**, set the VAULT_ADDR to `http://127.0.0.1:8230`.

```
export VAULT_ADDR='http://127.0.0.1:8230'
```{{execute T6}}

Unseal `node3`.

```
vault operator unseal $(grep 'Key 1:' key.txt | awk '{print $NF}')
```{{execute T6}}

> Remember that the server is using the file storage backend to persist Vault data; therefore, the shamir's unseal keys, encryption key and the initial root token are created and persisted at `/home/scrapbook/tutorial/vault-storage-file` when you initialized vault_1.

Execute the `vault operator raft join` command to join `node3` to `node1` Raft cluster.

```
vault operator raft join
```{{execute T6}}

You can verify the raft peer set.

```
vault operator raft list-peers
```{{execute T2}}

```
Node     Address           State       Voter
----     -------           -----       -----
node1    127.0.0.1:8211    leader      true
node2    127.0.0.1:8221    follower    true
node3    127.0.0.1:8231    follower    true
```

Now you have 3-node Vault cluster.

![](./assets/vault-ha-raft-1.png)
