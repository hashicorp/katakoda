The volume mounted to the pod in the **step 8** expects a secret stored at the
path `secret/data/db-pass`. When Vault is run in development a [KV secret
engine](https://www.vaultproject.io/docs/secrets/kv/kv-v2.html) is enabled at
the path `/secret`.


First, start an interactive shell session on the `vault-0` pod.

```shell
kubectl exec -it vault-0 /bin/sh
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

Lastly, exit the the `vault-0` pod.

```shell
exit
```{{execute}}