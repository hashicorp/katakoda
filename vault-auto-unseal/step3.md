Open the `config-vault-2.hcl`{{open}} file to review the server configuration file for **Vault 2**:

```
disable_mlock = true
ui=true

storage "file" {
  path = "~/vault-2/data"
}

listener "tcp" {
  address     = "0.0.0.0:8100"
  tls_disable = 1
}

seal "transit" {
  address = "http://127.0.0.1:8200"
  disable_renewal = "false"
  key_name = "autounseal"
  mount_path = "transit/"
  tls_skip_verify = "true"
}
```

Notice that the storage backend is set to `~/vault-2/data`, and the **Vault 2** will be listening to port **8100**. The **seal** stanza points to the **Vault 1** which is listening to port 8200. (**NOTE:** Since the client token is stored as `VAULT_TOKEN` environment variable, you don't need to set the `token` property in the configuration file.)


Start the vault server with configuration file.

```
vault server -config=config-vault-2.hcl
```{{execute T2}}

Click the **+** next to the opened Terminal, and select **Open New Terminal** to open third terminal window.

![New Terminal](./assets/ops-another-terminal.png)

In the third terminal, initialize your second Vault server (**Vault 2**).

```
VAULT_ADDR=http://127.0.0.1:8100 vault operator init -recovery-shares=1 \
         -recovery-threshold=1 > recovery-key.txt
```{{execute T3}}

By passing the `VAULT_ADDR`, the subsequent command gets executed against the second Vault server (http://127.0.0.1:8100). Notice that you are setting the number of **recovery** key and **recovery** threshold because there is no unseal keys with auto-unseal. Vault 2's master key is now protected by the `transit` secrets engine of **Vault 1**.

In the terminal where the server is running, you should see entries similar to:

```
...
[INFO]  core: security barrier not initialized
[INFO]  core: security barrier initialized: shares=1 threshold=1
[INFO]  core: post-unseal setup starting
...
[INFO]  core: vault is unsealed
[INFO]  core.cluster-listener: starting listener: listener_address=0.0.0.0:8101
...
```

Check the Vault 2 status.

```
VAULT_ADDR=http://127.0.0.1:8100 vault status
```{{execute T3}}

Vault 2 should be unsealed.

```
Key                      Value
---                      -----
Recovery Seal Type       shamir
Initialized              true
Sealed                   false
Total Recovery Shares    1
Threshold                1
...
```

To verify the auto-unseal, you can press **Ctrl + C** in the **Terminal 2** to stop the **Vault 2** process.  And then, restart **Vault 2** again.

```
vault server -config=config-vault-2.hcl
```{{execute T2}}

Check the Vault 2 status, and the server should have been unsealed.

```
VAULT_ADDR=http://127.0.0.1:8100 vault status
```{{execute T3}}
