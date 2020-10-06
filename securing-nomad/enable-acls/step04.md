Restart your Nomad nodes to read the new configuration values.

The scenario includes a helper script to restart the Nomad instances inside
of their namespaces.  Run the following commands:

```
restart_server1
```{{execute}}

```
restart_server2
```{{execute}}

```
restart_server3
```{{execute}}

```
restart_client
```{{execute}}

Once you restart the nodes, Nomad will become unavailable to users until
the ACL subsystem is bootstrapped. After ACLs are bootstrapped, users bearing
valid tokens can connect to the cluster.

To allow users to submit work while you are rolling out tokens to your
organization, you can configure an anonymous policy. The anonymous policy
dictates what access is available to users that have not submitted a token.
