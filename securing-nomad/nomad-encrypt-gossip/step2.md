<!-- markdownlint-disable no-inline-html -->

Add the token to the top of the server stanza to each of your server
configurations.

### Update server1's configuration

Start by opening `server1.hcl`{{open}} in the editor. Add the TLS stanza to the
top of the `server` stanza.

<pre class="file" data-filename="server1.hcl"
     data-target="insert" data-marker="server {">
server {
  # Encrypt gossip communication
  encrypt = "BSq3lEdNa+DFQBam11mhJTue3UmO2F//Cqs5oCnp/3w="
</pre>

### Update server2's configuration

Opening `server2.hcl`{{open}} in the editor. Add the TLS stanza to the top of
the `server` stanza.

<pre class="file" data-filename="server2.hcl"
     data-target="insert" data-marker="server {">
server {
  # Encrypt gossip communication
  encrypt = "BSq3lEdNa+DFQBam11mhJTue3UmO2F//Cqs5oCnp/3w="
</pre>

### Update server3's configuration

Open `server3.hcl`{{open}} in the editor. Add the TLS stanza to the top of
the `server` stanza.

<pre class="file" data-filename="server3.hcl"
     data-target="insert" data-marker="server {">
server {
  # Encrypt gossip communication
  encrypt = "BSq3lEdNa+DFQBam11mhJTue3UmO2F//Cqs5oCnp/3w="
</pre>
