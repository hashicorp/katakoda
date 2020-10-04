<style type="text/css">
.alert { position: relative; padding: .75rem 1.25rem; margin-bottom: 1rem; border: 1px solid transparent; border-radius: .25rem; }
.alert-info { color: #0c5460; background-color: #d1ecf1; border-color: #bee5eb; }
.lang-screenshot { -webkit-touch-callout: none; -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; }
</style>

You need to create a policy for the Consul agents.

First, load the management token out of your bootstrap file -
`export CONSUL_HTTP_TOKEN=$(awk '/SecretID/ {print $2}' ~/consul.bootstrap)`{{execute}}

Verify that your token is working by running `consul members`{{execute}}. If everything
is working correctly, you should receive output similar this.

**Example Output**

```screenshot
$ consul members
Node    Address           Status  Type    Build  Protocol  DC   Segment
host01  172.17.0.25:8301  alive   server  1.7.0  2         dc1  <all>
```

### Create a Consul agent policy

Run `touch ~/consul-agent-policy.hcl`{{execute}} to create a blank policy file.

Now, open `consul-agent-policy.hcl`{{open}} in the editor and paste in the contents.

<pre class="file" data-filename="consul-agent-policy.hcl" data-target="replace">
node_prefix "" {
   policy = "write"
}
service_prefix "" {
   policy = "read"
}
</pre>

Create the Consul ACL policy by running

```
consul acl policy create \
  -name "consul-agent-token" \
  -description "Consul Agent Token Policy" \
  -rules @consul-agent-policy.hcl
```{{execute}}

<div class="alert-info alert">

If you receive an error with "no such file or directory", make sure that you are
in your home directory by running `cd ~`{{execute}}

</div>

This will upload your policy file to the server and return information about
the generated policy.

**Example Output**

```screenshot
$ consul acl policy create \
>   -name "consul-agent-token" \
>   -description "Consul Agent Token Policy" \
>   -rules @~/consul-agent-policy.hcl
ID:           c1b732ff-bcc0-3c6a-3c53-d41c7e41797f
Name:         consul-agent-token
Description:  Consul Agent Token Policy
Datacenters:
Rules:
node_prefix "" {
   policy = "write"
}
service_prefix "" {
   policy = "read"
}
```

### Generate a Consul agent token

Generate a token associated with this policy and save it to a file named
consul-agent.token by running

```
consul acl token create \
  -description "Consul Agent Token" \
  -policy-name "consul-agent-token" | tee ~/consul-agent.token
```{{execute}}

**Example Output**

```screenshot
$ consul acl token create \
>   -description "Consul Agent Token" \
>   -policy-name "consul-agent-token" | tee ~/consul-agent.token
AccessorID:       fe7a6bce-5520-a6c6-4cc8-524e9071aed3
SecretID:         5f71b64f-0313-47ef-bebb-6ce398c254b2
Description:      Consul Agent Token
Local:            false
Create Time:      2020-02-20 19:44:06.984198307 +0000 UTC
Policies:
   c1b732ff-bcc0-3c6a-3c53-d41c7e41797f - consul-agent-token
```

In the next step, we will configure the Consul agent to use this token.
