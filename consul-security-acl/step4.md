
You can now use the bootstrap token to create other ACL policies for the rest of your datacenter.

The first policy you are going to create is for the server.

Open the `server_policy.hcl`{{open}} file to review the policy.

```hcl
# consul-server-one-policy.hcl
node "server-1" {
  policy = "write"
}
node_prefix "" {
   policy = "read"
}
service_prefix "" {
   policy = "read"
}
```

Create the policy and token with the `consul acl` command.

`consul acl policy create \
  -name consul-server-one \
  -rules @server_policy.hcl`{{execute T1}}


`consul acl token create \
  -description "consul-server-1 agent token" \
  -policy-name consul-server-one | tee server.token`{{execute T1}}

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px;">
  <p><strong>Warning: </strong>
  In this hands-on lab, you are redirecting the output of the `consul acl token create` command to a file to simplify operations in the next steps. In a real-life scenario, you want to make sure the token is stored in a safe place. If it is compromised, the ACL system can be abused.
</p></div>

Finally you can apply the token to the server as its `agent` token.

`consul acl set-agent-token agent $(cat server.token  | grep SecretID  | awk '{print $2}')`{{execute T1}}

You should receive the following output:

```plaintext
ACL token "agent" set successfully
```