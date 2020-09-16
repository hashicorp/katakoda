Once templates are created for the retrieval of the single
files, you can collect all the actions required by consul-template
to retrieve the certificates in one configuration file.

For this lab, you are going to use a template called `consul_template.hcl`{{open}}.

In it, you will define the following parameters to allow
`consul-template` to communicate with Vault:

* `address` : the address of your Vault server. In this lab, Vault runs on the same node as Consul so you can use `http://localhost:8200`.

* `token`  : a valid Vault ACL token with appropriate permissions. You will use Vault root token for this lab.

<div style="background-color:#eff5ff; color:#416f8c; border:1px solid #d0e0ff; padding:1em; border-radius:3px; margin:24px 0;">
  <p><strong>Info: </strong>

Earlier in the lab you used a root token to log in to Vault.
You will use that token in the next steps to generate
the TLS certs. This is not a best practice; the recommended security approach is to create
a new token based on a specific policy with limited privileges.
<br/>
In this case the appropriate policy would have been the following.
<br/>
```
path "pki_int/issue/consul-dc1" {
  capabilities = ["update"]
}
```
<br/>
Read more on Vault authorization process in our [Vault Policies](https://learn.hashicorp.com/tutorials/vault/getting-started-policies) tutorial. 

</p></div>

### Start consul-template

After configuration is completed, you can start `consul-template`.
You must provide the file with the `-config` parameter.

`consul-template -config "consul_template.hcl"`{{execute T2}}

Example output:

```
Configuration reload triggered
```

Verify the certificates are being correctly retrieved
by listing files in the destination directory:

`ls -l /opt/consul/agent-certs`{{execute T3}}


