Now that the Consul servers are configured, and that the datacenter is operational, 
it is possible to create more ACL tokens for different purposes.

Server tokens were created with the default lease time of one month, but you 
might want to set a shorter TTL for your tokens, or for specific tokens with 
high privileges, to reduce the risk of unwanted access in case of a token leak.

One good example for this are the tokens used for administrative tasks, such as
snapshots or configuration changes. 
In those cases you will probably create a token that uses the `global-management` 
policy and distribute it to the nodes or users that need to perform the operation.

To make sure those tokens have a shorter lifespan you can configure the `ttl` 
value when creating the role in Vault.

`vault write consul/roles/global-management policies=global-management ttl=120s`{{execute T1}}

Example output:

```
Success! Data written to: consul/roles/global-management
```

In this example you configured a `ttl` of two minutes, feel free to change that 
value to a longer one in case you need more time for your tests or operations.

### Create a short lived token for a snapshot

First you want to unset the `CONSUL_HTTP_TOKEN` environment variable to make sure 
you are not using the pre-configured token.

`unset CONSUL_HTTP_TOKEN`{{execute T1}}

You can confirm the token is not set for your environment anymore by trying to
run a command against Consul datacenter.

`consul snapshot save consul.snap`{{execute T1}}

The command should fail for lack or proper permissions:

```
Error saving snapshot: Unexpected response code: 403 (Permission denied)
```

Now, create a new token using the global-management role in Vault:

`vault read consul/creds/global-management -format=json | tee ./assets/secrets/acl-global-management-ttl.json`{{execute T1}}

Example output:

```
{
  "request_id": "f29f383f-30bd-66a0-a2ba-3de8bf517f61",
  "lease_id": "consul/creds/global-management/D9EpAflaJrJQL9VVs5ymNqjt",
  "lease_duration": 120,
  "renewable": true,
  "data": {
    "accessor": "cc2780e3-ffe5-2fc7-bf9a-c99b05199812",
    "local": false,
    "token": "677ca4ce-25f6-f34a-9b02-5abcfd5647aa"
  },
  "warnings": null
}
```

You can verify the `lease_duration` field now states `120` that means the token
will be valid for two minutes before being revoked and removed from Consul.

Setup your environment with the newly created token:

`export CONSUL_HTTP_TOKEN=$(cat ./assets/secrets/acl-global-management-ttl.json  | jq -r ".data.token")`{{execute T1}}

Finally try to take the snapshot again:

`consul snapshot save consul.snap`{{execute T1}}

This time the command should succeed and you should receive an output similar to:

```
Saved and verified snapshot to index 191
```

### Verify token expiration

To verify the token TTL is respected, wait for two minutes and try to perform 
another snapshot:

`consul snapshot save consul.snap`{{execute T1}}

The command should fail for lack or proper permissions:

```
Error saving snapshot: Unexpected response code: 403 (ACL not found)
```

You can also verify the token disappeared from both Consul and Vault UI.
