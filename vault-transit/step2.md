Once the `transit` secrets engine has been configured, any client with valid token with proper permission can send data to encrypt.

To encrypt your secret, use the `transit/encrypt` endpoint:

```
vault write transit/encrypt/<key_ring_name>
```

Vault does *NOT* store any of this data. The output you received is the ciphertext:

```
Key           Value
---           -----
ciphertext    vault:v1:Rrye8iuPT9ZrNEzpcHBa...
```

Execute the following command to encrypt a plaintext and save the resulting ciphertext in a file named, `cipher.txt`:

```
vault write -format=json transit/encrypt/orders \
      plaintext=$(base64 <<< "credit-card-number") \
      | jq -r ".data.ciphertext" > cipher.txt
```{{execute T1}}

The output you receive is a cipher-text: `cat cipher.txt`{{execute T1}}

> **NOTE:** You can pass non-text binary file such as a PDF or image. However, all plaintext data must be base64-encoded.


## Decrypt a cipher-text

To decrypt the ciphertext, invoke the `transit/decrypt` endpoint.

Execute the following command to decrypt the ciphertext stored in `cipher.txt` and save the resulting plaintext in the `plain.txt` file:

```
vault write -format=json transit/decrypt/orders \
      ciphertext=$(cat cipher.txt) \
      | jq -r ".data.plaintext" > plain.txt
```{{execute T1}}

The resulting data is base64-encoded.  Run the following command to decode it to get the raw plaintext:

```
base64 --decode <<< $(cat plain.txt)
```{{execute T1}}

**NOTE:** Alternatively, you can decrypt the ciphertext in one command:

```
vault write -field=plaintext transit/decrypt/orders \
      ciphertext=$(cat cipher.txt) \
      | base64 --decode
```

<br>

`clear`{{execute T1}}
