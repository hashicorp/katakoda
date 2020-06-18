The APIs needed to manage policies and tokens are not enabled until ACLs are
enabled. To begin, you need to enable the ACLs on the servers. If a multi-region
setup is used, the authoritative region should be enabled first.

To enable ACLs, set the enabled value of the `acl` stanza to true. The `acl` 
stanza is a top-level stanza.

```
acl {
  enabled = true
}
```
## Configure server nodes
Add the `acl` stanza to each of your server configurations.

**server1**

Start by opening `server1.hcl`{{open}} in the editor. Add the acl stanza.

<pre class="file" data-filename="server1.hcl" data-target="append">
acl {
  enabled = true
}
</pre>

**server2**

Open `server2.hcl`{{open}} in the editor, and add the acl stanza.

<pre class="file" data-filename="server2.hcl" data-target="append">
acl {
  enabled = true
}
</pre>

**server3**

Open `server3.hcl`{{open}} in the editor, and add the acl stanza.

<pre class="file" data-filename="server3.hcl" data-target="append">
acl {
  enabled = true
}
</pre>

## Configure client nodes

Nomad client nodes must also be configured with the ACL stanza.

**client**

Open `client.hcl`{{open}} in the editor, and add the acl stanza.

<pre class="file" data-filename="client.hcl" data-target="append">
acl {
  enabled = true
}
</pre>
