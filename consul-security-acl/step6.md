
You can query consul to retrieve the list of members and verify the client node properly started.

`consul members`{{execute T1}}

```plaintext
$ consul members
Node      Address          Status  Type    Build  Protocol  DC   Segment
server-1  172.18.0.2:8301  alive   server  1.7.3  2         dc1  <all>
client-1  172.18.0.3:8301  alive   client  1.7.3  2         dc1  <default>
```

### Create a non-privileged policy & token for CLI operations

Having your bootstrap token used in daily activities or exposed as an environment variable is **strongly discouraged**. It exposes you to several security risks.

A better approach would be to create a specific policy/token for each operator granting the minimum permissions required to perform their daily tasks.

For this lab, you can create a simple read-only policy to inspect the content of your Consul datacenter without the ability to make changes.

Open `read_policy.hcl`{{open}} to check the rules defined:

```plaintext
# read-only-policy.hcl
node_prefix "" {
   policy = "read"
}
service_prefix "" {
   policy = "read"
}
key-prefix "" {
   policy = "read"
}
```
Create the policy and token with the `consul acl` command.

`consul acl policy create \
  -name read-only \
  -rules @read_policy.hcl`{{execute T1}}

`consul acl token create \
  -description "read-only token" \
  -policy-name read-only | tee read-only.token`{{execute T1}}


### Change the token

The previous requests were successful because you still had the bootstrap token exported in `CONSUL_HTTP_TOKEN`. Unset that with the following command.

`unset CONSUL_HTTP_TOKEN`{{execute T1}}

After unsetting it, try querying Consul:

`consul members`{{execute T1}}

The fact that the command now returns an empty output indicates that ACLs are properly in place, and that an anonymous client will not be able to retrieve data from Consul even if they are able to reach the agent.

Finally, set the token for the command using the `CONSUL_HTTP_TOKEN` environment variable.

`export CONSUL_HTTP_TOKEN=$(cat read-only.token  | grep SecretID  | awk '{print $2}')`{{execute T1}}

Now try to retrieve the list of members from Consul again.

`consul members`{{execute T1}}

### Apply a token to Consul UI

The same token you used for your CLI command can be also applied to the Consul UI. Visit the [Consul UI](https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/ui) tab to apply one of the tokens generated in this lab to the UI.
