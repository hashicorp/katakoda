The applications that you deploy in the "Inject secrets into the pod" step
expect Vault to store a username and password stored at the path
`internal/database/config`.

Start an interactive shell session on the `vault-0` pod.

```shell
kubectl exec -it vault-0 -- /bin/sh
```{{execute}}

Your system prompt is replaced with a new prompt `/ $`. Commands issued at this
prompt are executed on the `vault-0` container.

Enable kv-v2 secrets at the path `internal`.

```shell
vault secrets enable -path=internal kv-v2
```{{execute}}

Create a secret at path `internal/database/config` with a `username` and `password`.

```shell
vault kv put internal/database/config username="db-readonly-username" password="db-secret-password"
```{{execute}}

Verify that the secret is defined at the path `internal/database/config`.

```shell
vault kv get internal/database/config
```{{execute}}

The secret is ready for the application.

Exit the `vault-0` pod.

```shell
exit
```{{execute}}