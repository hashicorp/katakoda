<!-- How would you feel about moving this before the Consul template step? Then in the Consul template step they can see the cert being rotated 

We could move the configuration into a specific step and explain at the bottom that we are going to automate the config part using consul-template

-->
Now configure Consul using the `server.json`{{open}}
configuration file provided with the lab.

Example content:

```
{
  "verify_incoming": true,
  "verify_outgoing": true,
  "verify_server_hostname": true,
  "ca_file": "/opt/consul/agent-certs/ca.crt",
  "cert_file": "/opt/consul/agent-certs/agent.crt",
  "key_file": "/opt/consul/agent-certs/agent.key",
  "auto_encrypt": {
    "allow_tls": true
  }
}
```

To configure TLS encryption for Consul, three files are required:

* `ca_file`   - CA (or intermediate) certificate to verify the identity of the other nodes.
* `cert_file` - Consul agent public certificate
* `key_file`  - Consul agent private key

For the first Consul startup you will use the certificate generated earlier.

You can manually create the files using the output of the command before now stored in `certs.txt` or you can use the following commands to extract the content from the file and place it into the right file and location.

`mkdir -p /opt/consul/agent-certs`{{execute T1}}

`grep -Pzo "(?s)(?<=certificate)[^\-]*.*?END CERTIFICATE[^\n]*\n" certs.txt | sed 's/^\s*-/-/g' > /opt/consul/agent-certs/agent.crt`{{execute T1}}

`grep -Pzo "(?s)(?<=issuing_ca)[^\-]*.*?END CERTIFICATE[^\n]*\n" certs.txt | sed 's/^\s*-/-/g' > /opt/consul/agent-certs/ca.crt`{{execute T1}}

`grep -Pzo "(?s)(?<=private_key)[^\-]*.*?END RSA PRIVATE KEY[^\n]*\n" certs.txt | sed 's/^\s*-/-/g' > /opt/consul/agent-certs/agent.key`{{execute T1}}

Proceed to the next step to start Consul server with TLS encryption enabled.
