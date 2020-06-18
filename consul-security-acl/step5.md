Once the server has a token assigned, it is possible to create a token for the client node.

Open the `client_policy.hcl`{{open}} file to review the policy.

```hcl
# consul-client-policy.hcl
node_prefix "client-" {
  policy = "write"
}
node_prefix "" {
   policy = "read"
}
service_prefix "" {
   policy = "read"
}
```

This policy will permit the registration of all nodes with a name starting with `client-`.

Create the policy and token with the `consul acl` command.

`consul acl policy create \
  -name consul-client \
  -rules @client_policy.hcl`{{execute T1}}

`consul acl token create \
  -description "consul-client agent token" \
  -policy-name consul-client | tee client.token`{{execute T1}}

### Configure Consul client

This time, since the client agent is not yet started, you will apply the token directly in the configuration. For this lab, we used the `client.token` file created in the previous step to automatically populate the file.

```bash
cat <<EOF >> ~/agent.hcl

acl = {
    enabled = true
    default_policy = "deny"
    enable_token_persistence = true
    tokens = {
        agent = "$(cat client.token | grep SecretID  | awk '{print $2}')"

    }
}
EOF
```{{execute T1}}

Check the `agent.hcl`{{open}} file to ensure the token is properly populated.

Once the file is modified to include the token, distribute it to the client.

`docker cp ./agent.hcl volumes:/client/agent.hcl`{{execute T1}}

### Start Consul client

Finally, start the Consul client.

`export JOIN_IP=$(consul members | grep server-1 | awk '{print $2}' | sed 's/:.*//g')`{{execute T1}}

`docker run \
    -d \
    -v client_config:/etc/consul.d \
    --name=client \
    consul agent \
     -node=client-1 \
     -join=${JOIN_IP} \
     -config-file=/etc/consul.d/agent.hcl`{{execute T1}}
