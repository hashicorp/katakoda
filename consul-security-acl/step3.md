
Once ACLs have been bootstrapped, you can use the bootstrap token to complete the configuration.

If the token is not set in the CONSUL_HTTP_TOKEN environment variable, or passed as a a command
line option, you will not be able to perform operations, or you will be presented only with a subset
of results.

`consul members`{{execute T1}}

The output for the command seems to show an empty datacenter.

### Configure the token

You can set the token for the command using the `CONSUL_HTTP_TOKEN` environment variable.

`export CONSUL_HTTP_TOKEN=$(cat consul.bootstrap  | grep SecretID  | awk '{print $2}')`{{execute T1}}

Now, try again to retrieve the list of members from Consul.

`consul members`{{execute T1}}

This time the output will show the server node.

```plaintext
$ consul members
Node      Address          Status  Type    Build  Protocol  DC   Segment
server-1  172.18.0.2:8301  alive   server  1.7.3  2         dc1  <all>
```
