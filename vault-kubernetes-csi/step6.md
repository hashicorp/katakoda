The Kubernetes-Secrets-Store-CSI-Driver Helm chart creates a definition for a
*SecretProviderClass* resource. This resource describes the parameters that are
given to the `provider-vault` executable. To configure it requires the IP
address of the Vault server, the name of the Vault Kubernetes authentication
role, and the secrets.

View the definition of the SecretProviderClass
`secret-provider-class-vault-database.yml`.

```shell
cat secret-provider-class-vault-database.yml
```{{execute}}.

The `vault-database` SecretProviderClass describes one secret object:

- `objectName` is a symbolic name for that secret, and the file name to write to.
- `secretPath` is the path to the secret defined in Vault.
- `secretKey` is a key name within that secret.

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