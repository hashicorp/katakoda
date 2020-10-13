Generate the CA's private key and certificate.

```
consul tls ca create -domain=nomad
```{{execute}}

The CA key (nomad-agent-ca-key.pem) will be used to sign certificates for Nomad
nodes and must be kept private. The CA certificate (nomad-agent-ca.pem) contains
the public key necessary to validate Nomad certificates and therefore must be
distributed to every node that requires access.

Create the server-role certificates

```
consul tls cert create -domain=nomad -dc=global -server
```{{execute}}

You will receive the following output.

```screenshot
==> WARNING: Server Certificates grants authority to become a
    server and access all state in the cluster including root keys
    and all ACL tokens. Do not distribute them to production hosts
    that are not server nodes. Store them as securely as CA keys.
==> Using nomad-agent-ca.pem and nomad-agent-ca-key.pem
==> Saved global-server-nomad-0.pem
==> Saved global-server-nomad-0-key.pem
```

Create the client-role certificates

```
consul tls cert create -domain=nomad -dc=global -client
```{{execute}}

You will receive the following output.

```screenshot
==> Using nomad-agent-ca.pem and nomad-agent-ca-key.pem
==> Saved global-client-nomad-0.pem
==> Saved global-client-nomad-0-key.pem
```

Create a CLI role certificates

```
consul tls cert create -domain=nomad -dc=global -cli
```{{execute}}

You will receive the following output.

```screenshot
==> Using nomad-agent-ca.pem and nomad-agent-ca-key.pem
==> Saved global-cli-nomad-0.pem
==> Saved global-clt-nomad-0-key.pem
```
