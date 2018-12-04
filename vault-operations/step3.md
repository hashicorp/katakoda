Outside of development mode, Vault servers are configured using a file. The format of this file is [HCL](https://github.com/hashicorp/hcl) or JSON. The configuration file for Vault is relatively simple.

Enter the following in the `config.hcl`{{open}} file:

<pre class="file" data-filename="config.hcl" data-target="replace">
# Use the file system as storage backend
storage "file" {
  path = "/data/vault"
}

listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = 1
}

ui = true
</pre>

The `storage` and `listener` stanzas are **required**.

In this example, the **file** storage backend stores Vault's data on the filesystem using a standard directory structure (`/data/vault`). It can be used for durable single server situations, or to develop locally where durability is not critical.  For production, you want to use scalable storage backend solution such as [Consul](https://www.vaultproject.io/docs/configuration/storage/consul.html).

The `listener` stanza specifies the TCP address/port that Vault listens to for incoming requests.

> For more details, refer to the [Vault Configuration](https://www.vaultproject.io/docs/configuration/index.html) documentation.

<br>

## Run Vault

Execute the following command to start the Vault server:

```
vault server -config=config.hcl
```{{execute T1}}

Notice the output indicating that the **Storage** is set to `file` system, and the **Listener** address is `127.0.0.1:8200`.

```
==> Vault server configuration:

                     Cgo: disabled
              Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "127.0.0.1:8201", max_request_duration:"1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: (not set)
                   Mlock: supported: true, enabled: true
                 Storage: file
                 Version: Vault v1.0.0
             Version Sha: c19cef14891751a23eaa9b41fd456d1f99e7e856
```

Next, you are going to initialize Vault.
