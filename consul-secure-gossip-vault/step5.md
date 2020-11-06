Once gossip encryption is configured the key gets stored in Consul data folder and is not possible to change it by changing the configuration file.

Consul provides a command, `consul keyring` that helps manage keys in the datacenter.

`consul keyring -list`{{execute T1}}

Example output

```
==> Gathering installed encryption keys...

WAN:
  FfRV9j6NXU9LlCI4zLZjjpZdj4Nrqsdm7R8YgzSHzHw= [1/1]

dc1 (LAN):
  FfRV9j6NXU9LlCI4zLZjjpZdj4Nrqsdm7R8YgzSHzHw= [1/1]
```

As you can notice the new key is not present into the output. This is because before using the new key uou need to install it into Consul.

To install and use a new key the steps are the following:

1. Get the new key.
1. Use `consul keyring -install "<new_gossip_key>"` to insert the key in the keyring. This will propagate the key to all nodes in the datacenter automatically.
1. Use `consul keyring -use "<new_gossip_key>"` to promote the key as primary.

After you install the new key the keyring will contain both the previous key and the new one.

Once you installed the new key and promoted it as primary, you should then remove all the former keys, to avoid nodes being able to join the gossip pool with an old key.

For this you can use the `command` option of `consul-template` that permits you to define a command to be executed every time a new version of the key is found.

### Write a rotation script

To automate the rotation tou can write a bash script that will manage the steps for you.

This lab contains an example script, `rotate_key.sh`{{open}}, that you can use for this.

First stop Consul template:

`killall -9 consul-template`{{execute T1}}

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px; margin:24px 0;">
  <p><strong>Warning:</strong><br>
  
  You should not use `killall` on a production server unless you are sure of the processes running on the node.

</p></div>

Then make the script executable:

`chmod +x rotate_key.sh`{{execute T1}}

Finally copy the script in a location contained in your `$PATH`:

`cp rotate_key.sh /opt`{{execute T1}}

### Start consul-template with new configuration

Now you can restart it using the new configuration file `consul_template_autorotate.hcl`{{open}} that contains the configuration

`consul-template -config "consul_template_autorotate.hcl"`{{execute T2}}

### Rotate Consul gossip key

Now every time you update the key value in Vault, `consul-template` will make sure that the key is installed in Consul too.

`vault kv put kv-v2/consul/config/encryption key=$(consul keygen) ttl=1s`{{execute T1}}

The script will pick up the `gossip.key` file containing the new key and use it to rotate the Consul gossip encryption key.

It should output the following lines:

```
==> Installing new gossip encryption key...
==> Changing primary gossip encryption key...
==> Removing gossip encryption key...
```

You can test the key is actually changed in Consul using again the `consul keyring` command:

`consul keyring -list`{{execute T1}}

