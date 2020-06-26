During initialization, the encryption keys were generated, and unseal keys are created. This only happens **once** when the server is started against a new backend that has never been used with Vault before.

In some cases, you may want to re-generate the master key and key shares. For examples:

- Someone joins or leaves the organization
- Security wants to change the number of shares or threshold of shares
- Compliance mandates the master key be rotated at a regular interval


In addition to rekeying the master key, there may be an independent desire to rotate the underlying encryption key Vault uses to encrypt data at rest.

![](./assets/rekey-and-rotate.png)

In Vault, `rekeying` and `rotating` are two separate operations. The process for generating a new master key and applying Shamir's algorithm is called "rekeying". The process for generating a new encryption key for Vault to encrypt data at rest is called "rotating".

<br>

## Rekeying Vault

**NOTE:** Rekeying the Vault requires a quorum of unseal keys.

First, initialize a rekeying operation.  At this point, you can specify the desired number of key shares and threshold.  Execute the following command to rekey Vault where the number of key shares is `3` and key threshold is `2`:

```
vault operator rekey -init -key-shares=3 -key-threshold=2 \
    -format=json | jq -r ".nonce" > nonce.txt
```{{execute T2}}

This will generate a nonce value and start the rekeying process. All other unseal keys must also provide this nonce value. This nonce value is not a secret, so it is safe to distribute over insecure channels like chat, email, or carrier pigeon.

Each unseal key holder runs the following command and enters their unseal key:

```
vault operator rekey -nonce=$(cat nonce.txt) \
    $(grep 'Key 1:' key.txt | awk '{print $NF}')
```{{execute T2}}

Notice that the output indicates that the **unseal progress** is now `1/3`.

Enter the second unseal key:

```
vault operator rekey -nonce=$(cat nonce.txt) \
    $(grep 'Key 2:' key.txt | awk '{print $NF}')
```{{execute T2}}


Finally, enter the third unseal key:

```
vault operator rekey -nonce=$(cat nonce.txt) \
    $(grep 'Key 3:' key.txt | awk '{print $NF}')
```{{execute T2}}


When the final unseal key holder enters their key, Vault will output the new unseal keys similar to following:

```
Key 1: a4By/JU6xqMxXG95FtcShLldGS4GDZmcUcCD4Q83cl2b
Key 2: dWBDfbTicxDwCbmi7TQnKBdecdyfWWi+25Pj2xN+vlnb
Key 3: zZk7kYLu02E/UENLmCjBSzu76SQaqnVt9RtcYeTQYsf4

Operation nonce: cc9f9311-7945-3b91-9af4-96d94eba83ae

Vault rekeyed with 3 key shares an a key threshold of 2. Please securely
distributed the key shares printed above. When the Vault is re-sealed,
restarted, or stopped, you must supply at least 2 of these keys to unseal it
before it can start servicing requests.
```

> Vault supports **PGP encrypting** the resulting unseal keys and creating backup encryption keys for disaster recovery.

<br>

## Rotating the Encryption Key

Unlike rekeying the Vault, rotating Vault's encryption key does not require a quorum of unseal keys. Anyone with the proper permissions in Vault can perform the encryption key rotation.

To trigger a key rotation, execute the following command:

```
vault operator rotate
```{{execute T2}}

The output shows the key version and installation time. This will add a new key to the keyring. All new values written to the storage backend will be encrypted with this new key.
