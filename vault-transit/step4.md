Let's encrypt another data and save its ciphertext in `cipher2.txt`:

```
vault write -format=json transit/encrypt/orders \
      plaintext=$(base64 <<< "visa-card-number") \
      | jq -r ".data.ciphertext" > cipher2.txt
```{{execute T1}}

Compare the ciphertexts:

```
cat cipher.txt
cat cipher2.txt
```{{execute T1}}

Notice that the first ciphertext starts with `vault:v1:`.  After rotated the encryption key, the ciphertext starts with `vault:v2:`.  This indicates that the data gets encrypted using the latest version of the key after the rotation.


You can upgrade already-encrypted data with a new key by invoking `transit/rewrap` endpoint.  

Execute the following command to rewrap your secret:

```
vault write transit/rewrap/orders ciphertext=$(cat cipher.txt)
```{{execute T1}}

Notice that the resulting ciphertext now starts with `vault:v2:`.  

## Important Note

To rewrap the data, you don't need to decrypt it. You can simply pass the ciphertext to the Vault. Vault will decrypt the value using the appropriate key in the keyring and then encrypted the resulting plaintext with the newest key in the keyring. Therefore, this operation does not reveal the plaintext data.
