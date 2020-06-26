Initialization is the process configuring the Vault. This only happens once when the server is started against a new backend that has never been used with Vault before. During initialization, the encryption keys are generated, unseal keys are created, and the initial root token is setup.

To initialize Vault use `vault operator init` operation.
<br>

Click the **+** next to the opened Terminal, and select **Open New Terminal**.

![New Terminal](./assets/ops-another-terminal.png)

In the **Terminal 2**, set the `VAULT_ADDR`:

```
export VAULT_ADDR='http://127.0.0.1:8200'
```{{execute T2}}

Now, execute the `vault operator init` command to initialize Vault:

```
vault operator init > key.txt
```{{execute T2}}

<br>
## Unseal Vault

Every initialized Vault server starts in the **sealed** state. From the configuration, Vault can access the physical storage, but it can't read any of it because it doesn't know how to decrypt it.

In order to prevent no one person from having complete access to the system, Vault employs [Shamir's Secret Sharing Algorithm](https://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing). Under this process, a secret is divided into a subset of parts such that a subset of those parts are needed to reconstruct the original secret. Vault makes heavy use of this algorithm as part of the unsealing process.

![Shamir's Secret Sharing](./assets/vault-autounseal.png)

Typically each of these key shares is distributed to trusted parties in the organization. These parties must come together to "unseal" the Vault by entering their key share.

By default, the number of shared keys is `5` and quorum of `3` unseal keys are required to unseal vault (`key.txt`{{open}}).  

> NOTE: This is configurable during the initialization using `-key-shares` and `-key-threshold` parameters.)

<br>

Execute the `vault operator unseal` command to enter the first unseal key:

```
vault operator unseal \
    $(grep 'Key 1:' key.txt | awk '{print $NF}')
```{{execute T2}}

Notice that the output indicates that the **unseal progress** is now `1/3`.

Pass the second unseal key:

```
vault operator unseal \
    $(grep 'Key 2:' key.txt | awk '{print $NF}')
```{{execute T2}}


Finally, pass the third unseal key:

```
vault operator unseal \
    $(grep 'Key 3:' key.txt | awk '{print $NF}')
```{{execute T2}}

Now, Vault is unsealed and ready to accept requests.
