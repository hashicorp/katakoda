<style type="text/css">
.lang-screenshot { -webkit-touch-callout: none; -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; }
</style>

Unset the Consul token in your shell session.

`unset CONSUL_HTTP_TOKEN`{{execute}}

Now, try running countdash.nomad again. You will receive an error explaining
that you need to supply a Consul token.

`nomad run countdash.nomad`{{execute}}

**Example Output**

```screenshot
$ nomad run countdash.nomad
Error submitting job: Unexpected response code: 500 (operator token denied: missing consul token)
```

Nomad will not allow you to submit a job to the cluster without providing a
Consul token that has write access to the Consul service that the job defines.

You can supply the token in a few ways:

- `CONSUL_HTTP_TOKEN` environment variable
- `-consul-token` flag on the command line
- `-X-Consul-Token` header on API calls

Reload your management token into the CONSUL_HTTP_TOKEN environment variable.

`export CONSUL_HTTP_TOKEN=$(awk '/SecretID/ {print $2}' ~/consul.bootstrap)`{{execute}}

Now, try running countdash.nomad again. This time it will succeed.

`nomad run countdash.nomad`{{execute}}