Initialize Vault with one key share and one key threshold.

```shell
kubectl exec vault-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > cluster-keys.json
```{{execute}}

The [`operator
init`](https://www.vaultproject.io/docs/commands/operator/init.html) command
generates a master key that it disassembles into key shares `-key-shares=1` and
then sets the number of key shares required to unseal Vault `-key-threshold=1`.
These key shares are written to the output as unseal keys in JSON format
`-format=json`. Here the output is redirected to a file named
`cluster-keys.json`.

View the unseal key found in `cluster-keys.json`{{open}}.

```shell
cat cluster-keys.json | jq -r ".unseal_keys_b64[]"
```{{execute}}

Create a variable named VAULT_UNSEAL_KEY to capture the Vault unseal key.

```shell
VAULT_UNSEAL_KEY=$(cat cluster-keys.json | jq -r ".unseal_keys_b64[]")
```{{execute}}

Unseal Vault running on the `vault-0` pod.

```shell
kubectl exec vault-0 -- vault operator unseal $VAULT_UNSEAL_KEY
```{{execute}}

The `operator unseal` command reports that Vault is initialized and unsealed.

Unseal Vault running on the `vault-1` pod.

```shell
kubectl exec vault-1 -- vault operator unseal $VAULT_UNSEAL_KEY
```{{execute}}

Unseal Vault running on the `vault-2` pod.

```shell
kubectl exec vault-2 -- vault operator unseal $VAULT_UNSEAL_KEY
```{{execute}}

Verify all the Vault pods are running and ready.

```shell
kubectl get pods
```{{execute}}
