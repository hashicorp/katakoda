

This server is running locally in development mode.

Export an environment variable for the `vault` CLI to address the target Vault
server.

```shell
export VAULT_ADDR=http://localhost:8200
```{{execute}}


Display the status of the target Vault server.

```shell
vault status
```{{execute}}

The response shows that the Vautl server is initialized and unsealed.

The server writes its operation logs and audit log to the file system.

Show the operation logs.

```shell
cat ~/log/vault.log
```{{execute}}

Show the audit logs.

```shell
cat ~/log/vault_audit.log | jq
```{{execute}}

The file audit log writes JSON objects to the log file. The `jq` command parses,
filters and presents that data to you in a more digestable way.
