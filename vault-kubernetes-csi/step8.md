With the secret stored in Vault, the authentication configured and role created,
the `provider-vault` extension installed and the *SecretProviderClass* defined
it is finally time to create a pod that mounts the desired secret.

View the definition of the pod in
`pod-webapp.yml`{{open}}.

The pod, named `webapp`, defines and mounts a read-only
volume to `/mnt/secrets-store`. The objects defined in the `vault-database`
*SecretProviderClass* are written as files within that path.

Apply a pod named `webapp`.

```shell
kubectl apply --filename pod-webapp.yml
```{{execute}}

Verify that the webapp pod is running in the `default` namespace.

```shell
kubectl get pods
```{{execute}}

Finally, read the password secret written to the file system at
`/mnt/secrets-store/db-pass` on the webapp pod.

```shell
kubectl exec webapp -- cat /mnt/secrets-store/db-pass ; echo
```{{execute}}

The value displayed matches the `password` value for the secret
`secret/db-pass`.