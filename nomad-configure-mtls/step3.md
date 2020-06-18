Copy your certificates to your Nomad nodes. For this scenario, you can put them
all into /etc/nomad.d/tls.

Create the destination folder.

```
mkdir -p /etc/nomad.d/tls
```{{execute}}

Copy the CA certificate to all nodes. <strong>Do not copy the CA key file.</strong>

```
cp nomad-agent-ca.pem /etc/nomad.d/tls
```{{execute}}

Copy the server certificate and server keyfile to the server nodes.

```
cp global-server-nomad-0* /etc/nomad.d/tls
```{{execute}}

Copy the client certificate and client keyfile to the client nodes.

```
cp global-client-nomad-0* /etc/nomad.d/tls
```{{execute}}
