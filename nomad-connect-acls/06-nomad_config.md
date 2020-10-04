<style type="text/css">
.lang-screenshot { -webkit-touch-callout: none; -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; }
</style>

Open the `nomad_config.hcl`{{open}} file. Add a `consul` stanza with your token.

```hcl
consul {
  token = "«your nomad agent token»"
}
```

You can run this command to do some magic and inject your Nomad agent token
you created in the previous step.

```bash
cat <<EOF >> ~/nomad_config.hcl

consul {
  token = "$(awk '/SecretID/ {print $2}' ~/nomad-agent.token)"
}
EOF
```{{execute}}

Run the `systemctl restart nomad`{{execute}} command to restart Nomad to load
these changes.
