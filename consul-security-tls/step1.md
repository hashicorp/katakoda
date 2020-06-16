
Consul has a built-in certification authority (CA) to reduce configuration friction. To use the 
built-in CA, you must initialize it. 

`consul tls ca create`{{execute T1}}

The CA creation command generates two files, `consul-agent-ca.pem` and `consul-agent-ca-key.pem`. 

You can use the embedded editor to check the content of the files.

#### Create server certificate

Next, create a certificate for the server.

`consul tls cert create -server`{{execute T1}}

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px;">
  <p><strong>Warning: </strong>
  In a production environment it is recommended to create different certificates for each server.
</p></div>

#### Client certificates

With the auto encrypt method enabled, you do not need to create client certificates.
Consul creates and distributes the client certificates for you. 

Review the [Secure Agent Communication with TLS Encryption](https://learn.hashicorp.com/consul/security-networking/certificates) guide to learn about the different
certificate generation and distrubution options.

