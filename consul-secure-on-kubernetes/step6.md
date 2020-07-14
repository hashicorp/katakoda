### ACL enforcement validation

Try inserting a value to the Key-Value store.

`consul kv put -ca-file consul-agent-ca.pem password=1234`{{execute T1}}

This command fails with the following message:

`Error! Failed writing data: Unexpected response code: 403 (Permission denied)`

You have not yet supplied an ACL token so the command fails.
This proves ACLs are being enforced.

### Setting an ACL Token

List all Kubernetes secrets with the following command:

`kubectl get secrets`{{execute T1}}

One of the secrets is named `katacoda-consul-bootstrap-acl-token`. This
secret contains the Consul ACL bootstrap token.

Run the following command to set the `CONSUL_HTTP_TOKEN`
environment variable from this secret.

`export CONSUL_HTTP_TOKEN=$(kubectl get secrets/katacoda-consul-bootstrap-acl-token --template={{.data.token}} | base64 -d)`{{execute interrupt T1}}

Try to set a Key-Value store value again.

`consul kv put -ca-file consul-agent-ca.pem password=1234`{{execute T1}}

The command succeeds. You have proven that ACLs are being enforced.
