With the secret stored in Vault, the authentication configured and role created,
the `provider-vault` extension installed and the *SecretProviderClass* defined
it is finally time to create a pod that mounts the desired secret.

View the definition of the pod in
`pod-webapp.yml`{{open}}.

The pod, named `webapp`, defines and mounts a read-only
volume to `/mnt/secrets-store`. The object defined in the `vault-database`
*SecretProviderClass* is written as a file within that path.

Apply a pod named `webapp`.

```shell
kubectl apply --filename pod-webapp.yml
```{{execute}}

Verify that the webapp pod is running in the default namespace.

```shell
kubectl get pods
```{{execute}}

Wait until the `webapp` pod is
[`Running`](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase)
and ready (`1/1`).

Finally, read the password secret written to the file system at
`/mnt/secrets-store/db-pass` on the `webapp` pod.

```shell
kubectl exec webapp -- cat /mnt/secrets-store/db-pass ; echo
```{{execute}}

The value displayed matches the `password` value for the secret
`secret/db-pass`.