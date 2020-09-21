You can use consul-template in your Consul datacenter to
integrate with Vault's PKI secrets engine to generate
and renew dynamic X.509 certificates.

### Create and populate the templates directory

This lab will demonstrate the TLS certificate automation
for the server instances so that you can deploy a Consul
datacenter that will generate and retrieve certificates
from Vault and configure the servers automatically.

You need to create templates that consul-template can use
to render the actual certificates and keys on the agent in
your datacenter. In this lab, you will place these templates
in `/opt/consul/templates`.

Create a directory called templates in `/opt/consul`.

`sudo mkdir -p /opt/consul/templates`{{execute T2}}

### Server templates

As mentioned earlier, to configure mTLS for Consul servers you need the following files:

* `agent.crt` : Consul server node public certificate for the dc1 datacenter.
* `agent.key` : Consul server node private key for the dc1 datacenter.
* `ca.crt`    : CA public certificate.

You can instruct consul-template to generate and retrieve those files from Vault using the following templates:

`agent.crt.tpl`{{open}}

Example content:

```
{{ with secret "pki_int/issue/consul-dc1" "common_name=server.dc1.consul" "ttl=2m" "alt_names=localhost" "ip_sans=127.0.0.1"}}
{{ .Data.certificate }}
{{ end }}
```

The template will use the `pki_int/issue/consul-dc1` endpoint that Vault exposes to generate new certificates. It also mentions the common name and alternate names for the certificate.

Note that the TTL is now set to 2m meaning the certificates will be rotated every two minutes.

`agent.key.tpl`{{open}}

Example content:

```
{{ with secret "pki_int/issue/consul-dc1" "common_name=server.dc1.consul" "ttl=2m" "alt_names=localhost" "ip_sans=127.0.0.1"}}
{{ .Data.private_key }}
{{ end }}
```

`ca.crt.tpl`{{open}}

Example content:

```
{{ with secret "pki_int/issue/consul-dc1" "common_name=server.dc1.consul" "ttl=2m"}}
{{ .Data.issuing_ca }}
{{ end }}
```

### Consul CLI templates

The TLS certificates in the previous section will be used to
configure TLS encryption for your Consul datacenter. If you
need to use the Consul CLI on one of your agent nodes you should
consider generating different certificates only for CLI operations.

`cli.crt.tpl`{{open}}

Example content:

```
{{ with secret "pki_int/issue/consul-dc1" "ttl=2m" }}
{{ .Data.certificate }}
{{ end }}
```

`cli.key.tpl`{{open}}

Example content:

```
{{ with secret "pki_int/issue/consul-dc1" "ttl=2m" }}
{{ .Data.private_key }}
{{ end }}
```

Once you have reviewed the templates for consul-template,
you can copy the templates into `/opt/consul/templates`.

`cp *.tpl /opt/consul/templates/`{{execute T2}}
