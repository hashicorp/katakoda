<style type="text/css">
.lang-screenshot { -webkit-touch-callout: none; -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; }
</style>

Next, to create the Nomad agent policy file, run `touch ~/nomad-server-policy.hcl`{{execute}}
to create a blank file. Open `nomad-server-policy.hcl`{{open}} in the editor and
add paste in the following contents.

<pre class="file" data-filename="nomad-server-policy.hcl" data-target="replace">
agent_prefix "" {
  policy = "write"
}

node_prefix "" {
  policy = "write"
}

service_prefix "" {
  policy = "write"
}

acl = "write"
</pre>

Create the Nomad server policy with the Consul CLI.

```shell
consul acl policy create \
  -name "nomad-server-token" \
  -description "Nomad Server Token Policy" \
  -rules @nomad-server-policy.hcl
```{{execute}}

<div class="alert-info alert">

If you receive an error with "no such file or directory", make sure that you are
in your home directory by running `cd ~`{{execute}}

</div>

**Example Output**

```screenshot
$ consul acl policy create \
  -name "nomad-server-token" \
  -description "Nomad Server Token Policy" \
  -rules @nomad-server-policy.hcl
ID:           aec3686a-e475-060e-5a39-263a5c0f298b
Name:         nomad-server-token
Description:  Nomad Server Token Policy
Datacenters:
Rules:
agent_prefix "" {
  policy = "write"
}
node_prefix "" {
  policy = "write"
}
service_prefix "" {
  policy = "write"
}
acl = "write"
```

Generate a token associated with this policy and save it to a file named
nomad-agent.token.

```shell
consul acl token create \
  -description "Nomad Demo Agent Token" \
  -policy-name "nomad-server-token" | tee ~/nomad-agent.token
```{{execute}}

**Example Output**

```screenshot
$ consul acl token create \
  -description "Nomad Demo Agent Token" \
  -policy-name "nomad-server-token" | tee ~/nomad-agent.token
AccessorID:       a073f54a-b51a-59ae-a014-6e95564885ea
SecretID:         427d2bb2-9c43-5d54-39ce-d6115c5c10d9
Description:      Nomad Demo Agent Token
Local:            false
Create Time:      2020-02-12 22:30:42.402962642 +0000 UTC
Policies:
   fed881c2-a9c1-b89d-3941-056fca77eb17 - nomad-server-token
```

In the next step, you will configure Nomad to use this token.
