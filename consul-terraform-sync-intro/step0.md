
The Consul datacenter is configured to have ACL enabled so you will need a token
to perform operations.

During the deployment we saved the token into a configuration file 
`consul_env.conf`. This way you can setup the environment by sourcing the file
directly:

`source consul_env.conf`{{execute}}

#### View datacenter members

Once you have set the environment variables you can use `consul members` to
retrieve information on your datacenter.

`consul members`{{execute}}

You should receive an output similar to the following:

```screenshot
Node       Address          Status  Type    Build  Protocol  DC   Segment
server-1   172.19.0.3:8301  alive   server  1.9.3  2         dc1  <all>
cts-node   172.19.0.1:8301  alive   client  1.9.3  2         dc1  <default>
service-1  172.19.0.4:8301  alive   client  1.9.3  2         dc1  <default>
service-2  172.19.0.5:8301  alive   client  1.9.3  2         dc1  <default>
```

### View catalog services

Using the `catalog` command you can also list the services present in the Consul
catalog.

`consul catalog services -tags`{{execute T1}}

```snapshot
api                    v1
api-sidecar-proxy      v1
consul                 
web                    v1
web-sidecar-proxy      v1
```

You should get an output similar to the one above indicating the presence of
several services. Note the `v1` tag associated to some of the services. You
are going to use the tags later to filter among services for your network 
automation.

### Access Consul UI

Using the [Consul UI](https://[[HOST_SUBDOMAIN]]-1443-[[KATACODA_HOST]].environments.katacoda.com/ui) tab you can also access the Consul UI for the datacenter.

To view all the content in the UI you will need to login using an ACL token. You 
can use the master token for that.

`echo $CONSUL_HTTP_TOKEN`{{execute T1}}

