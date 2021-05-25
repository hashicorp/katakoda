Restart your Nomad nodes to read the new configuration values.

The scenario includes a helper script to restart the Nomad instances inside
their network namespaces. Run the following commands.

`restart_server1`{{execute}}

`restart_server2`{{execute}}

`restart_server3`{{execute}}

Verify that the servers all restarted and are available:

`nomad server members`{{execute}}

All nodes should have “alive” as their status.
