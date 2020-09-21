### Create a role to map names in Vault to a Consul ACL policy

In the previous step you created a policy, `consul-servers`, to define the server agents' permissions.

You are going to use that policy when creating tokens for Consul servers.

A recommended approach to generate tokens for identical policies is to associate the policy to a role.
Roles allow you to group a set of policies and service identities into a reusable higher-level entity that can be applied to many tokens.

For this lab, you are going to configure a role that maps a name
in Vault to a set of Consul ACL policies. When users generate credentials, if they are generated against this role they will automatically get associated to the policies of that role.

`vault write consul/roles/consul-server-role policies=consul-servers`{{execute T1}}

Example output:

```
Success! Data written to: consul/roles/consul-server-role
```

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px; margin:24px 0;">
  <p><strong>Warning:</strong> The tokens will only be associated to the policies that are represented by the role at token creation time. If you change the role configuration, for example by associating it with a new policy, the change will only be reflected by the tokens you generate after it. Previous tokens will not be affected. 
  <br/>
  This prevents you from mistakenly associating extra permissions to pre-existing tokens.

</p></div>
