
### Create a Consul server policy

Once the ACL system is initialized, you should still find some warnings in your Consul logs:

`cat /opt/consul/logs/consul.log`{{execute T1}}

```
 [WARN]  agent: Node info update blocked by ACLs: node=c19d6af9-760b-a3cc-bbdd-b4f7209a79de accessorID=00000000-0000-0000-0000-000000000002
 [WARN]  agent: Coordinate update blocked by ACLs: accessorID=00000000-0000-0000-0000-000000000002
```

These warnings indicate that: 
- the agent is trying to update its info in your Consul datacenter, but has been denied by the ACL system because it does not have the correct permissions.
- the agent does not have an assigned token to perform the request (because `00000000-0000-0000-0000-000000000002` is the anonymous policy used when no token is presented)

The first step towards a more fine grained ACL approach is to create individual tokens for the server agents so that they can interact properly with the rest of the Consul datacenter without being assigned an administrative token.

For this lab, you will create a policy that permits server agents to register themselves. The servers will follow the naming pattern `server-<count_or_id>`, and have the necessary permissions to locate other agents and discover services.

This policy will be used by Vault when creating tokens for Consul.

Open the `server_policy.hcl`{{open}} file to review the policy.

```hcl
# consul-server-policy.hcl
node_prefix "server-" {
  policy = "write"
}
node_prefix "" {
   policy = "read"
}
service_prefix "" {
   policy = "read"
}
```

Create the policy with the `consul acl` command.

`consul acl policy create \
  -name consul-servers \
  -rules @server_policy.hcl`{{execute T1}}

Once the policy is created you need to associate it to a token in order to use it.  

<div style="background-color:#eff5ff; color:#416f8c; border:1px solid #d0e0ff; padding:1em; border-radius:3px; margin:24px 0;">
<p><strong>Info:</strong> In a standalone scenario, where Vault is not deployed yet, you can still configure your ACL system by storing them in Consul. You can use the `consul acl token create` command or the `/acl/token` REST API resource.
<br/>
Review [Secure Consul with Access Control Lists (ACLs)](https://learn.hashicorp.com/tutorials/consul/access-control-setup-production) to learn how.

<!-- Follow the links in the last step to learn how. -->

</p></div>
