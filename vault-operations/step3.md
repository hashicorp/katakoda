Outside of development mode, Vault servers are configured using a file. The format of this file is [HCL](https://github.com/hashicorp/hcl) or JSON. The configuration file for Vault is relatively simple.

Enter the following in the `config.hcl`{{open}} file:

<pre class="file" data-filename="config.hcl" data-target="replace">
# Use the file system as storage backend
storage "raft" {
  path    = "./vault/data"
  node_id = "node1"
}

listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = 1
}

api_addr = "http://127.0.0.1:8200"
cluster_addr = "https://127.0.0.1:8201"
ui = true
</pre>

The `storage` and `listener` stanzas are **required**. In this example, the **raft** storage backend stores Vault's data at `/root/vault`.

The `api_addr` parameter specifies the address to advertise to route client requests. The `cluster_addr` parameter indicates the address and port to be used for communication between the Vault nodes in a cluster.

To learn how to setup an highly available (HA) cluster using the integrated storage, try the [Vault Integrated Storage](https://www.katacoda.com/hashicorp/scenarios/vault-raft) Katacoda scenario.

The `listener` stanza specifies the TCP address/port that Vault listens to for incoming requests.

> For more details, refer to the [Vault Configuration](https://www.vaultproject.io/docs/configuration/index.html) documentation.

<br>

## Run Vault

Execute the following command to start the Vault server:

```
mkdir -p vault/data
vault server -config=config.hcl
```{{execute T1}}

Notice the output indicating that the **Storage** is set to `file` system, and the **Listener** address is `127.0.0.1:8200`.

```
==> Vault server configuration:

             Api Address: http://127.0.0.1:8200
                     Cgo: disabled
         Cluster Address: https://127.0.0.1:8201
              Go Version: go1.14.4
              Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "127.0.0.1:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: info
                   Mlock: supported: true, enabled: true
           Recovery Mode: false
                 Storage: raft (HA available)
                 Version: Vault v1.5.0
```

Next, you are going to initialize Vault.
