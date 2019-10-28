One of the benefits of using the Vault `transit` secrets engine is its ability to easily rotate the encryption keys. Keys can be rotated manually by a human, or an automated process which invokes the key rotation API endpoint through cron, a CI pipeline, a periodic Nomad batch job, Kubernetes Job, etc.

Vault maintains the versioned keyring and the operator can decide the minimum version allowed for decryption operations. When data is encrypted using Vault, the resulting ciphertext is prepended with the version of the key used to encrypt it.

Execute the following command to review the `orders` key detail:

```
vault read transit/keys/orders
```{{execute T1}}

Note that there is only one version of the key; therefore, data gets encrypted with version 1 of the `orders` key.

```
Key                       Value
---                       -----
...
keys                      map[1:1531434474]
latest_version            1
min_decryption_version    1
min_encryption_version    0
...
```

To rotate the encryption key, invoke the `transit/keys/<key_ring_name>/rotate` endpoint.

Execute the following command to rotate the `orders` key:

```
vault write -f transit/keys/orders/rotate
```{{execute T1}}

Check the `orders` key information again:

```
vault read transit/keys/orders
```{{execute T1}}

Now, there are two versions of keys.

`clear`{{execute T1}}
