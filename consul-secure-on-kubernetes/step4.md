Next, configure gossip encryption, TLS, ACLS,
and then upgrade the installation. For this hands-on
lab, the `secure-dc1.yaml`{{open}} file has been provided with
all the necessary options set to secure the Consul service mesh.

### Configure Gossip encryption

Notice that the file now includes a `gossipEncryption` stanza.

```yaml
gossipEncryption:
    secretName: "consul-gossip-encryption-key"
    secretKey: "key"
```

Exit the server container running in **Terminal 1**.

`exit`{{execute T1}}

Register the gossip encryption key secret.

`kubectl create secret generic consul-gossip-encryption-key --from-literal=key=$(consul keygen)`{{execute T1}}

### TLS

TLS is enabled by the following stanza.

```yaml
tls:
    enabled: true
    enableAutoEncrypt: true
    verify: true
```

By setting these values, you have instructed Consul to generate
and distribute all the necessary certificates, keys, and secrets.

### ACLs

ACLs are enabled by the following stanza.

```yaml
acls:
    manageSystemACLs: true
```

By setting manageSystemACLs to true, the ACL system will configure itself.

### Helm upgrade

Upgrade the installation. The upgrade may take a minute or two to complete.

`helm upgrade -f ./secure-dc1.yaml katacoda hashicorp/consul --wait`{{execute T1}}

### Verify the upgrade

Verify the upgrade by reviewing the status
of pods using the following command:

`watch kubectl get pods`{{execute T1}}

Once all pods have a status of `Running` you can proceed to the next step.
