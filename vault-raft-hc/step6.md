View the help message for the `vault operator raft autopilot` command.

```
clear
vault operator raft autopilot -help
```{{execute T4}}

Display the current cluster status.

```
vault operator raft autopilot state
```{{execute T4}}

## Autopilot Configuration

Now, check the current autopilot configuration.

```
clear
vault operator raft autopilot get-config
```{{execute T4}}

The **Cleanup Dead Servers** parameter is set to `false`.

Update the autopilot configuration to enable the dead server cleanup. For demonstration, set the **Dead Server Last Contact Threshold** to 10 seconds, and the **Server Stabilization Time** to 30 seconds.

```
vault operator raft autopilot set-config \
    -dead-server-last-contact-threshold=10 \
    -server-stabilization-time=30 \
    -cleanup-dead-servers=true \
    -min-quorum=3
```{{execute T4}}

Verify the configuration change. `clear`{{execute T4}}

```
vault operator raft autopilot get-config
```{{execute T4}}

## Add a new node

Start a new Vault server, `node4`.

```
mkdir raft-node4
vault server -config=config-node4.hcl > raft-node4/node4.log 2>&1 &
```{{execute T4}}

Check the server status.

```
VAULT_ADDR='http://127.0.0.1:4200' vault status
```{{execute T4}}

**NOTE:** Before unsealing `node4`, check the server log (`raft-node4/node4.log`{{open}}) to ensure that `node4` has join the cluster.

```
[INFO]  core: successfully joined the raft cluster: leader_addr=http://127.0.0.1:8200
```

Unseal the server.

```
VAULT_ADDR='http://127.0.0.1:4200' vault operator unseal $(grep 'Key 1:' key.txt | awk '{print $NF}')
```{{execute T4}}

Now, check the cluster state.

```
clear
vault operator raft autopilot state
```{{execute T4}}

Initially, `node4` is added to the cluster as a `non-voter`, and then eventually, it becomes a `voter`.

```
Healthy:                      true
Failure Tolerance:            1
Leader:                       node2
Voters:
   node2
   node1
   node3
   node4
...snip...
```
