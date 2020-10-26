Enter the following command to start the Vault server in development mode.  

```
vault server -dev -dev-root-token-id="root"
```{{execute T1}}


Scroll up the Terminal to locate the following output:

```
==> Vault server configuration:

             Api Address: http://127.0.0.1:8200
                     Cgo: disabled
         Cluster Address: https://127.0.0.1:8201
              Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "127.0.0.1:8201", tls: "disabled")
               Log Level: info
                   Mlock: supported: true, enabled: false
                 Storage: inmem
                 Version: Vault v1.0.0
             Version Sha: c19cef14891751a23eaa9b41fd456d1f99e7e856

WARNING! dev mode is enabled! In this mode, Vault runs entirely in-memory
and starts unsealed with a single unseal key. The root token is already
authenticated to the CLI, so you can immediately begin using Vault.
```

When Vault is running in development mode, it runs entirely in-memory that the data does not get **persisted**. This build-in, pre-configured server is useful for local development, testing and exploration.

<br>

## Login with root token

Click the **+** next to the opened Terminal, and select **Open New Terminal**.

![New Terminal](./assets/ops-another-terminal.png)

In the **Terminal 2**, set the `VAULT_ADDR` environment variable:

```
export VAULT_ADDR='http://127.0.0.1:8200'
```{{execute T2}}

Login with the generated root token.

```
vault login root
```{{execute T2}}


Now, you are logged in as a `root` and ready to play!
