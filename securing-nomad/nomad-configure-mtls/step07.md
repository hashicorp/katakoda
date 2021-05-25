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

Verify that the servers all start and are available. Before attempting to run
Nomad CLI commands, you will have to configure several environment variables
in order to configure the CLI for your new mTLS configuration

```
export NOMAD_CACERT="${HOME}/tls/nomad-agent-ca.pem"
export NOMAD_CLIENT_CERT="${HOME}/tls/global-cli-nomad-0.pem"
export NOMAD_CLIENT_KEY="${HOME}/tls/global-cli-nomad-0-key.pem"
export NOMAD_ADDR="https://127.0.0.1:4646"
```{{execute}}

Now you can run the `nomad server members` command.

```
nomad server members
```{{execute}}

All nodes should have "alive" as their status.

Verify that the client node is also available.

```
nomad node status
```{{execute}}

