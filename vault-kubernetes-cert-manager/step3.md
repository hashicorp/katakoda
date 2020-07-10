Vault run in standalone mode starts uninitialized and in the sealed state. Prior
to initialization the storage backend is not prepared to receive data.

```shell
kubectl exec vault-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > init-keys.json
```{{execute}}

The operator init command generates a master key that it disassembles into key
shares `-key-shares=1` and then sets the number of key shares required to unseal
Vault `-key-threshold=1`. These key shares are written to the output as unseal
keys in JSON format `-format=json`. Here the output is redirected to a file
named `init-keys.json`.

View the unseal key found in `init-keys.json`{{open}}.

```shell
cat init-keys.json | jq -r ".unseal_keys_b64[]"
```{{execute}}

Create a variable named VAULT_UNSEAL_KEY to capture the Vault unseal key.

```shell
VAULT_UNSEAL_KEY=$(cat init-keys.json | jq -r ".unseal_keys_b64[]")
```{{execute}}

Unseal Vault running on the `vault-0` pod.

```shell
kubectl exec vault-0 -- vault operator unseal $VAULT_UNSEAL_KEY
```{{execute}}

The `operator unseal` command reports that Vault is initialized and unsealed.

Get all the pods within the default namespace.

```shell
kubectl get pods
```{{execute}}

Wait until the `vault-0` pod reports that it is running and ready (`1/1`).

Vault is ready for you to login with the root token generated during the
initialization.

View the root token found in `init-keys.json`{{open}}.

```shell
cat init-keys.json | jq -r ".root_token"
```{{execute}}

Create a variable named `VAULT_ROOT_TOKEN` to capture the root token.

```shell
VAULT_ROOT_TOKEN=$(cat init-keys.json | jq -r ".root_token")
```{{execute}}

Login to Vault running on the `vault-0` pod with the `$VAULT_ROOT_TOKEN`.

```shell
kubectl exec vault-0 -- vault login $VAULT_ROOT_TOKEN
```{{execute}}

The Vault server is ready to be configured as a certificate store.
