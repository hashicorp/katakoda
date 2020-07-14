### Review a security enbabled config file

For this hands-on lab, the `secure-dc1.yaml`{{open}} file has been provided with
all the necessary options set to secure the Consul service mesh.

### Configure Gossip encryption

If you haven't opened the `secure-dc1.yaml`{{open}} file, please do so now.
Notice that the file now includes a `gossipEncryption` stanza.

```yaml
gossipEncryption:
    secretName: "consul-gossip-encryption-key"
    secretKey: "key"
```

Use the following command to register a gossip encryption key secret.

`kubectl create secret generic consul-gossip-encryption-key --from-literal=key=$(consul keygen)`{{execute T1}}

### Configure TLS

TLS is enabled by the following stanza.

```yaml
tls:
    enabled: true
    enableAutoEncrypt: true
    verify: true
    caCert:
        secretName: consul-ca-cert
        secretKey: tls.crt
    caKey:
        secretName: consul-ca-key
        secretKey: tls.key
```

To generate a CA, run the following command:

`consul tls ca create`{{execute T1}}

This command generated consul-agent-ca.pem and consul-agent-ca-key.pem. Add these secrets to Kubernetes.

`kubectl create secret generic consul-ca-cert --from-file='tls.crt=./consul-agent-ca.pem'`{{execute T1}}

`kubectl create secret generic consul-ca-key --from-file='tls.key=./consul-agent-ca-key.pem'`{{execute T1}}

You have now generated and registered all the necessary secrets to support both gossip encryption
and TLS.

### Configure managed ACLs

By setting manageSystemACLs to true, the ACL system will configure itself. You
do not need to take any action beyond setting the value in the config file.

```yaml
acls:
    manageSystemACLs: true
```

### Helm upgrade

Upgrade the installation with these changes. The upgrade may take a minute or two to complete.

`helm upgrade -f ./secure-dc1.yaml katacoda hashicorp/consul --wait`{{execute T1}}

### Verify the upgrade

Now verify that everything upgrades successfully by reviewing the status
of running pods using the following command:

`kubectl get pods`{{execute T1}}

Once all pods have a status of Running, as illustrated in the following output,
you can proceed to the next step.
