The Kubernetes-Secrets-Store-CSI-Driver Helm chart creates a definition for a
*SecretProviderClass* resource. This resource describes the parameters that are
given to the `provider-vault` executable. To configure it requires the IP
address of the Vault server, the name of the Vault Kubernetes authentication
role, and the secrets.

Open the definition of the SecretProviderClass
`secret-provider-class-vault-database.yml`{{open}}.

The `vault-database` SecretProviderClass describes one secret object:

- `objectPath` is the path to the secret defined in Vault. Prefaced with a
  forward-slash.
- `objectName` a key name within that secret
- `objectVersion` - the version of the secret. When none is specified the latest
  is retrieved.

Create a SecretProviderClass named `vault-database`.

```shell
kubectl apply --filename secret-provider-class-vault-database.yml
```{{execute}}

Verify that the SecretProviderClass, named `vault-database` has been defined
in the default namespace.

```shell
kubectl describe SecretProviderClass vault-database
```{{execute}}

This resource is ready to be mounted as a volume on a pod.