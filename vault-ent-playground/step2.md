At this point, you can run Vault Enterprise in development mode. In this mode, Vault Enterprise runs entirely in-memory and starts unsealed with a single unseal key. The root token is already authenticated to the CLI, so you can immediately begin using Vault Enterprise.

Execute the following command to start Vault Enterprise in development mode:

```
vault server -dev -dev-root-token-id="root"
```{{execute}}

> This is a built-in, pre-configured server that is ***not*** very secure but useful for playing with Vault Enterprise locally.

Click the **+** next to the opened Terminal, and select **Open New Terminal**.

<img src="https://education-yh.s3-us-west-2.amazonaws.com/screenshots/ops-another-terminal.png" alt="New Terminal"/>

In the **Terminal 2**, set the `VAULT_ADDR` environment variable:

```
export VAULT_ADDR='http://127.0.0.1:8200'
```{{execute T2}}

Login with the root token.

```
vault login root
```{{execute T2}}

> **Important Note:** Without a valid license, Vault Enterprise server will be sealed after ***30 minutes***. In other words, you have 30 free minutes to explorer the Enterprise features. To explore Vault Enterprise further, you can [sign up for a free 30-day trial](https://www.hashicorp.com/products/vault/trial).


## What to try

You can create a **namespace** by executing the following command.

```
vault namespace create education
```{{execute T2}}

Execute the following command to create a child namespace called `training` under the `education` namespace.

```
vault namespace create -namespace=education training
```{{execute T2}}

Create child namespace called `certification` under the `education` namespace.

```
vault namespace create -namespace=education certification
```{{execute T2}}

List the existing namespace on the root.

```
vault namespace list
```{{execute T2}}

List the existing namespace on the education namespace.

```
vault namespace list -namespace=education
```{{execute T2}}

To learn more about the **namespace**, refer to the [Secure Multi-Tenancy with Namespaces](https://learn.hashicorp.com/vault/security/namespaces) guide.
