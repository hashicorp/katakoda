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

Copy the client certificate and client keyfile to the client nodes. Typically
these are different nodes. In this scenario our nodes all share the
/etc/nomad.d/tls folder, so copy it there.

```
cp global-client-nomad-0* /etc/nomad.d/tls
```{{execute}}

Create a TLS directory in your home directory and copy the CA certificate and
your CLI certificate and keyfile there.

```
mkdir ~/tls
```{{execute}}

```
cp nomad-agent-ca.pem ~/tls
```{{execute}}

```
cp global-cli-nomad-0* ~/tls
```{{execute}}
