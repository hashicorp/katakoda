View the help message for the `vault operator raft autopilot` command.

```
clear
vault operator raft autopilot -help
```{{execute T4}}

Display the current cluster status.

```
vault operator raft autopilot state
```{{execute T4}}

Now, check the current autopilot configuration.

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
    -min-quorum=3
```{{execute T4}}

Verify the configuration change. `clear`{{execute T4}}

```
vault operator raft autopilot get-config
```{{execute T4}}


Add `node4` to the cluster.

```
mkdir raft-node4
vault server -config=config-node4.hcl
```{{execute T4}}

Unseal the server.

```
VAULT_ADDR='http://127.0.0.1:4200' vault operator unseal $(grep 'Key 1:' key.txt | awk '{print $NF}')
```{{execute T6}}

Now, check the cluster state.

```
vault operator raft autopilot state
```{{execute T4}}
