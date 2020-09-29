### Configure the Consul CLI

Now, configure your development host so that you
can issue commands with the Consul CLI. The following environment
variables need to get to set so that your your development host
can interact with Consul.

- `CONSUL_HTTP_ADDR`
- `CONSUL_HTTP_TOKEN`
- `CONSUL_SSL_VERIFY`

For specifics, review `consul`{{open}}.

`bash consul.sh`{{execute T1}}

### Access Consul

Now, verify that your development host is configured correctly
to interact with your HCS Managed App.

`consul members`{{execute T1}}

Example output:

```plaintext
Node                                               Address        Status  Type    Build      Protocol  DC       Segment
11eaebe7-28cc-d041-894b-0242ac110006-vmss-1000000  10.0.0.4:8301  left    server  1.8.0+ent  2         westus2  <all>
```

### Access to the Consul UI

Now, access the Consul UI.

`echo $CONSUL_HTTP_ADDR`{{execute T1}}

Copy the link in the output to access the **Consul UI** in a new
browser tab.

Next, retrieve the bootstrap token.

`echo $CONSUL_HTTP_TOKEN`{{execute T1}}

Copy that token, and use it to login to the Consul UI.
