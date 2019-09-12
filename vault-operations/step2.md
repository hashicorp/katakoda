At this point, you can run Vault in development mode. In this mode, Vault runs entirely in-memory and starts unsealed with a single unseal key. The root token is already authenticated to the CLI, so you can immediately begin using Vault.

Execute the following command to start Vault in development mode:

```
vault server -dev -dev-root-token-id="root"
```{{execute}}

> This is a built-in, pre-configured server that is ***not*** very secure but useful for playing with Vault locally.

Scroll up to find the following message:

```
You may need to set the following environment variable:

    $ export VAULT_ADDR='http://127.0.0.1:8200'

The unseal key and root token are displayed below in case you want to
seal/unseal the Vault or re-authenticate.

Unseal Key: zA1ujDttNWW9REd5I+VHCcYnmYiZHmBDs2QxZCVDgZc=
Root Token: root
```

Click the **+** next to the opened Terminal, and select **Open New Terminal**.

<img src="https://education-yh.s3-us-west-2.amazonaws.com/screenshots/ops-another-terminal.png" alt="New Terminal"/>

In the **Terminal 2**, set the `VAULT_ADDR` environment variable:

```
export VAULT_ADDR='http://127.0.0.1:8200'
```{{execute T2}}

Login with the generated root token.

```
vault login root
```{{execute T2}}

Now, you can run vault commands to manage your secrets using the dev server.

For example:

```
vault kv put secret/customer/james name="James Bond" organization="MI6"
```{{execute T2}}

<br>

Return to the _first terminal_ where Vault server is running, and **CTRL + C** to terminate the dev server.  


Next, you are going to learn how to configure Vault for non-dev environment.
