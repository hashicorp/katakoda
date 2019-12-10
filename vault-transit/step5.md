Execute the key rotation command a few times to generate multiple versions of the key:

```
vault write -f transit/keys/orders/rotate
vault write -f transit/keys/orders/rotate
vault write -f transit/keys/orders/rotate
vault write -f transit/keys/orders/rotate
```{{execute T1}}

Check the `orders` key information:

```
vault read transit/keys/orders
```{{execute T1}}

```
Key                       Value
---                       -----
...
keys                      map[6:1531439714 1:1531439594 2:1531439667 3:1531439714 4:1531439714 5:1531439714]
latest_version            6
min_decryption_version    1
min_encryption_version    0
...
```

You can see that the current version of the key is **6**. There is no restriction about the minimum encryption key version, and any of the key versions can decrypt the data (`min_decryption_version`).

Run the following command to enforce the use of the encryption key at version **5** or later to decrypt the data.

```
vault write transit/keys/orders/config min_decryption_version=5
```{{execute T1}}

Now, verify the `orders` key configuration:

```
vault read transit/keys/orders
```{{execute T1}}

<br>

## Question

What happens to those data that were encrypted with older version of the key which does not meet the minimum key version restriction?

## Answer

Vault rejects to decrypt the ciphertext:

```
vault write -format=json transit/decrypt/orders \
      ciphertext=$(cat cipher2.txt) \
      | jq -r ".data.plaintext" > plain.txt
```{{execute T1}}

The output includes the following error message.

```
* ciphertext or signature version is disallowed by policy (too old)
```

This means that the data encrypted with key earlier than 5 cannot be decrypted. As a best practice, you should rotate your ciphertext when you rotate the encryption key to keep the data valid.
