With the secret stored in Vault, the authentication configured and role created,
the `provider-vault` extension installed and the *SecretProviderClass* defined
it is finally time to create a pod that mounts the desired secret.

Create the `webapp-sa` service account.

```shell
cat <<EOF | kubectl apply -f -
kind: ServiceAccount
apiVersion: v1
metadata:
  name: webapp-sa
EOF
```{{execute}}

View the definition of the pod in `pod-webapp.yml`.

```shell
cat pod-webapp.yml
```{{execute}}.

The `webapp` pod defines and mounts a read-only volume to `/mnt/secrets-store`.
The object defined in the `vault-database` *SecretProviderClass* is written as a
file within that path.

Apply a pod named `webapp`.

```shell
kubectl apply --filename pod-webapp.yml
```{{execute}}

Get all the pods within the default namespace.

```shell
kubectl get pods
```{{execute}}

Wait until the `webapp` pod is running and ready (`1/1`).

Display the password secret written to the file system at
`/mnt/secrets-store/db-password` on the `webapp` pod.

```shell
kubectl exec webapp -- cat /mnt/secrets-store/db-password ; echo
```{{execute}}

The value displayed matches the `password` value for the secret
`secret/db-pass`.