You can use consul-template in your Consul datacenter to
integrate with Vault's KV Secrets Engine to dynamically rotate
you Consul gossip encryption keys.

### Create and populate the templates directory

This lab will demonstrate the gossip encryption rotation on a single server instance so that you can deploy a Consul datacenter that will automatically rotate the gossip encryption key based on updates in Vault.

You need to create templates that consul-template can use
to render the actual certificates and keys on the nodes in
your cluster. In this lab, you will place these templates
in `/opt/consul/templates`.

Create a directory called templates in `/opt/consul`.

`sudo mkdir -p /opt/consul/templates`{{execute}}

### Configure template file

`gossip.key.tpl`{{open}}

`cp *.tpl /opt/consul/templates/`{{execute T1}}

### Start consul-template

After configuration is completed, you can start `consul-template`.
You must provide the file with the `-config` parameter.

`consul-template -config "consul_template.hcl"`{{execute T2}}

At this time you will have the gossip key saved in `/opt/consul/gossip/gossip.key`.

`cat /opt/consul/gossip/gossip.key`{{execute T1}}

Example output:

```
5EyLRD8B27B7kN+T547GDnj9dmABCyRvSvrPSw56rL0=
```

#### Test file update

consul-template will automatically update the file every time the key is updated in Vault.

You can test this by generating a new key:

`vault kv put kv-v2/consul/config/encryption key=$(consul keygen) ttl=1s`{{execute T1}}

Example output:
```
Success! Data written to: kv-v2/consul/config/encryption
```

This will update the file:

`cat /opt/consul/gossip/gossip.key`{{execute T1}}

Example output:

```
zHzhJvDyKMn+QJVNHDEhJYKUhnMu9pQw/4lQ82izTxc=
```

If the key is not updated, wait for a few seconds and then read the `gossip.key` file again.

In the next step you will learn how to automate the gossip key rotation for your Consul datacenter.
