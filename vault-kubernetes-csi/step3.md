The volume mounted to the pod in the **step 8** expects a secret stored at the
path `secret/data/db-pass`.

Start an interactive shell session on the `vault-0` pod.

```shell
kubectl exec -it vault-0 -- /bin/sh
```{{execute}}

Your system prompt is replaced with a new prompt `/ $`. Commands issued at this
prompt are executed on the `vault-0` container.

Create a secret at the path `secret/db-pass` with a `password`.

```shell
vault kv put secret/db-pass password="db-secret-password"
```{{execute}}

Verify that the secret is readable at the path `secret/db-pass`.

```shell
vault kv get secret/db-pass
```{{execute}}

Exit the the `vault-0` pod.

```shell
exit
```{{execute}}