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

For the first Consul startup, you will use the certificate generated earlier.

Use the following commands to extract the two certificates and private key from the `certs.txt` and place them into the right file and location.

`mkdir -p /opt/consul/agent-certs`{{execute T1}}

`grep -Pzo "(?s)(?<=certificate)[^\-]*.*?END CERTIFICATE[^\n]*\n" certs.txt | sed 's/^\s*-/-/g' > /opt/consul/agent-certs/agent.crt`{{execute T1}}

`grep -Pzo "(?s)(?<=issuing_ca)[^\-]*.*?END CERTIFICATE[^\n]*\n" certs.txt | sed 's/^\s*-/-/g' > /opt/consul/agent-certs/ca.crt`{{execute T1}}

`grep -Pzo "(?s)(?<=private_key)[^\-]*.*?END RSA PRIVATE KEY[^\n]*\n" certs.txt | sed 's/^\s*-/-/g' > /opt/consul/agent-certs/agent.key`{{execute T1}}

Proceed to the next step to start Consul server with TLS encryption enabled.
