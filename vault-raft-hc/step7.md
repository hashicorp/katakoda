Stop `node3` to mimic a node failure.

```
ps aux | grep "node3" | grep -v grep | awk '{print $2}' | xargs kill
```{{execute T7}}

Display the current cluster status.

```
clear
vault operator raft autopilot state
```{{execute T7}}

The **Healthy** parameter is now `false`; however, `node3` is still listed as a voter.

```
Healthy:                      false
Failure Tolerance:            0
Leader:                       node2
Voters:
   node2
   node1
   node4
   node3
Servers:
      ...snip...
   node3
      Name:            node3
      Address:         127.0.0.1:3201
      Status:          voter
      Node Status:     left
      Healthy:         false
      Last Contact:    16.726313767s
      Last Term:       4
      Last Index:      63
    ...snip...
```

The health status of `node3` is `false` and the **Node Status** is `left`.

Wait for a few more seconds and check the cluster state again.

```
vault operator raft autopilot state
```{{execute T7}}

Now the cluster should be healthy with fault tolerance of `1`.

```
Healthy:                      true
Failure Tolerance:            1
Leader:                       node2
Voters:
   node2
   node1
   node4
Servers:
   node1
      Name:            node1
      Address:         127.0.0.1:8201
      ...snip...
```

Now, `node3` is no longer listed under the **Voters** list.
