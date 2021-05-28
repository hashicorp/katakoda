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

Check the current autopilot configuration.

```
vault operator raft autopilot get-config
```{{execute T4}}

The **Cleanup Dead Servers** parameter is set to `false`.

Update the autopilot configuration to enable the dead server cleanup. For demonstration, set the **Dead Server Last Contact Threshold** to 10 seconds, and the **Server Stabilization Time** to 30 seconds.

```
vault operator raft autopilot set-config \
    -dead-server-last-contact-threshold=10 \
    -server-stabilization-time=30 \
    -cleanup-dead-servers=true \
    -min-quorum=2
```{{execute T4}}

Verify the configuration change. `clear`{{execute T4}}

```
vault operator raft autopilot get-config
```{{execute T4}}

Now, check to see what happened to `node3`.

```
vault operator raft autopilot state
```{{execute T4}}
