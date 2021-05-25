Add the `tls` stanza to each of your server configurations.

Start by opening `server1.hcl`{{open}} in the editor.

Add the TLS stanza.

<pre class="file" data-filename="server1.hcl" data-target="append">
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


You will need to do this for server2.hcl and server3.hcl.

Open `server2.hcl`{{open}} in the editor, and add the tls stanza.

<pre class="file" data-filename="server2.hcl" data-target="append">
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

Finally, open `server3.hcl`{{open}} in the editor, and add the tls stanza.

<pre class="file" data-filename="server3.hcl" data-target="append">
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