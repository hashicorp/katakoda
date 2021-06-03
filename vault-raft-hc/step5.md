Currently, `node1` is the active (leader) node. Let's see what happens when `node1` steps down from its role as the active node.

From **Terminal2** and execute the following code against the `node1`.

```
vault operator step-down
```{{execute T2}}

Now, check and see what happened to the cluster.

```
vault operator raft list-peers
```{{execute T2}}

The cluster shows that `node2` is promoted to be the active node.

```
Node     Address           State       Voter
----     -------           -----       -----
node1    127.0.0.1:8201    follower    true
node2    127.0.0.1:2201    leader      true
node3    127.0.0.1:3201    follower    true
```
