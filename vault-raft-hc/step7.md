Stop `node3` to mimic a node failure.

```
ps aux | grep "node3" | grep -v grep | awk '{print $2}' | xargs kill
```{{execute T4}}

Display the current cluster status.

```
clear
vault operator raft autopilot state
```{{execute T4}}

The **Healthy** parameter is now `false`; however, `node3` is still listed as a voter.

```
Healthy:                      false
Failure Tolerance:            0
Leader:                       node2
Voters:
   node2
   node1
   node3
Servers:
   node1
      ...snip...
   node3
      Name:            node3
      Address:         127.0.0.1:3201
      Status:          voter
      Node Status:     alive
      Healthy:         false
      Last Contact:    1m46.742599633s
      Last Term:       4
      Last Index:      51
```

Wait for a few more seconds and check the cluster state again.

```
vault operator raft autopilot state
```{{execute T4}}

Now the cluster should be healthy with fault tolerance of `1`.
