There are a few components that need to be added to the environment; we are
adding them now. Wait for the complete message and then move to the
next step.

**Example Output**

```screenshot
 - Install prerequisites
 - Install Consul locally
 - Installing Consul x.y.z
 - Installing consul-template x.y.z
 - Installing Vault locally
 - Installing Vault x.y.z
```

and concluding with

```
- Complete! Move on to the next step.
```

Once this message appears, you are ready to continue.

### Configuration files

While you wait for the provision to complete you can review the configuration files you are going to use for the lab:

| File                   | Description |
|:-----------------------|-------------|
| `ca.crt.tpl`           | Template for CA certificate |
| `agent.crt.tpl`        | Template for agent certificate |
| `agent.key.tpl`        | Template for agent key |
| `consul_template.hcl`  | `consul-template` configuration file |
| `cli.crt.tpl`          | Template for CLI certificate |
| `cli.key.tpl`          | Template for CLI key |
| `server.json`          | Server agent configuration file |
| `server-tls.json`      | Server agent TLS configuration file |

<!--

| `tls-policy.hcl`{{open}}                |  |
| `vault_provisioner_policy.hcl`{{open}}  |  |

-->