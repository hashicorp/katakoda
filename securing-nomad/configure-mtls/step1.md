The first step to configuring TLS for Nomad is generating certificates. In order
to prevent unauthorized cluster access, Nomad requires all certificates be
signed by the same Certificate Authority (CA). This should be a private CA and
not a public one like Let's Encrypt, as any certificate signed by this CA will be
allowed to communicate with the cluster.

Nomad certificates may be signed by an intermediate CAs as long as the root CA is
the same. You must append all intermediate CAs to the cert_file.

There are a variety of tools for managing your own CA,
like the PKI secrets backend in Vault. For the sake of simplicity this guide
will use Consul's internal CA and the `consul tls ca` command.

Make a directory to maintain your CA and certificate material.

```
mkdir -p /opt/nomad/ca
```{{execute}}

Change into that folder

```
cd /opt/nomad/ca
```{{execute}}

