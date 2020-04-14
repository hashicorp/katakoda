By default, Nomad does not require that an operator validate themselves and will
create ACL permissions at any level the Nomad server token can. In some
scenarios, this can allow an operator to escalate their privileges to that of
Nomad server.

To prevent this, you can set the `allow_unauthenticated` option to false.

Open the `nomad_config.hcl`{{open}} file and add `allow_unauthenticated` value
inside of the `consul` configuration block.

<pre class="file" data-target="clipboard">
  allow_unauthenticated = false
</pre>

Run the `systemctl restart nomad`{{execute}} command to restart Nomad to load
these changes.

In the next step we will run a job using operator-provided credentials.