
Vault's Consul secrets engine generates Consul ACL tokens dynamically based on 
Consul ACL policies, and must be enabled before it can perform its functions.

`vault secrets enable consul`{{execute T1}}

Example output:

```
Success! Enabled the consul secrets engine at: consul/
```

### Configure Vault to connect and authenticate to Consul

The Consul secrets engine requires a management token, with unrestricted 
privileges, to interact with Consul.

First, create a management token in Consul:

`consul acl token create \
    -policy-name=global-management \
    -format=json | tee ./assets/secrets/acl_management.json`{{execute T1}}

Export the management token as an environment variable:

`export CONSUL_MGMT_TOKEN=$(cat ./assets/secrets/acl_management.json | jq -r ".SecretID")`{{execute T1}}

Configure the engine with Consul's address, management token, and CA certificate:

`vault write consul/config/access \
    address=https://server.dc1.consul:443 \
    token=${CONSUL_MGMT_TOKEN} \
    ca_cert=@./assets/secrets/consul-agent-ca.pem`{{execute T1}}

Example output:

```
Success! Data written to: consul/config/access
```

