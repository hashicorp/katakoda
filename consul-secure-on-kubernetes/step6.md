<style>
    pre.console {
        background-color: #383732 !important;
        font-family: "Fira Mono","DejaVu Sans Mono",Menlo,Consolas,"Liberation Mono",Monaco,"Lucida Console",monospace;
        color: white;
        overflow: auto;
        padding: 5px;
    }
</style>
### ACL enforcement validation

Now, try running `consul debug`.

`consul debug -ca-file ca.pem`{{execute T1}}

This command fails with the following message:

<pre class="console">
==> Capture validation failed: error querying target agent: Unexpected response code: 403 (Permission denied). verifyconnectivity and agent address
</pre>

This command is not permitted for the anonymous token. You must supply
an ACL token with the proper permissions. This proves ACLs are being enforced.

### Setting an ACL Token

Run the following command to set the `CONSUL_HTTP_TOKEN`
environment variable from the Kubernetes `consul-bootstrap-acl-token`
secret.

`export CONSUL_HTTP_TOKEN=$(kubectl get secrets/consul-bootstrap-acl-token --template={{.data.token}} | base64 -d)`{{execute interrupt T1}}

Try to run `consul debug` again.

`consul debug -ca-file ca.pem`{{execute T1}}

The command succeeds. You have proven that ACLs are being enforced.
