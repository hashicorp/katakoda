We have preconfigured a set of Nomad mTLS certificates and placed them in
/etc/nomad.d/tls.

Add a `tls` stanza to your `nomad_config.hcl`{{open}} file.

<pre class="file" data-filename="nomad_config.hcl" data-target="append">
tls {
  http = true
  rpc  = true

  ca_file   = "/etc/nomad.d/tls/nomad-agent-ca.pem"
  cert_file = "/etc/nomad.d/tls/global-server-nomad-0.pem"
  key_file  = "/etc/nomad.d/tls/global-server-nomad-0-key.pem"

  verify_server_hostname = true
  verify_https_client    = true
}
</pre>

Restart the Nomad service.

```
systemctl restart nomad
```{{execute}}

