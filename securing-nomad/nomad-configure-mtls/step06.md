Add the `tls` stanza to your client configurations.

Start by opening `client.hcl`{{open}} in the editor.

Add the TLS stanza.
<pre class="file" data-filename="client.hcl" data-target="append">
tls {
  http = true
  rpc  = true

  ca_file   = "/etc/nomad.d/tls/nomad-agent-ca.pem"
  cert_file = "/etc/nomad.d/tls/global-client-nomad-0.pem"
  key_file  = "/etc/nomad.d/tls/global-client-nomad-0-key.pem"

  verify_server_hostname = true
  verify_https_client    = true
}
</pre>

