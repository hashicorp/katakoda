Once verified, you can access the _backend_ service and that the *round_robin* policy is applied you can apply new policies for the load balancing and verify how these affect the requests' resolution.

### Configure service defaults

In order to enable service resolution and apply load balancer policies, you need to define the service protocol in a `service-defaults` configuration entry.

The lab provides a configuration file for this, `default.hcl`{{open}} that you can use to apply the configuration.

```
Kind           = "service-defaults"
Name           = "backend"
Protocol       = "http"
```

`docker exec server consul config write /etc/consul.d/default.hcl`{{execute}}

Example output:

```
Config entry written: service-defaults/backend
```

### Configure service resolution with sticky sessions

A common requirements for many applications is to have the possibility to redirect all the requests from a specific client to the same server.

You can achieve this configuration using the `maglev` policy provided in the `hash-resolver.hcl`{{open}} file:

```
Kind           = "service-resolver"
Name           = "backend"
LoadBalancer = {
  EnvoyConfig = {
    Policy = "maglev"
    HashPolicies = [
      {
        Field = "header"
        FieldValue = "x-user-id"
      }
    ]
  }
}
```

This configuration creates a `service-resolver` configuration, for the service `backend` that uses the content of the `x-user-id` header to resolve requests.

You can apply the policy using the `consul config` command.

`docker exec server consul config write /etc/consul.d/hash-resolver.hcl`{{execute}}

Example output:

```
Config entry written: service-resolver/backend
```

### Verify the policy is applied

Once the policy is in place, you can test it using the `curl` command and applying the `x-user-id` header to the request:

`docker exec client curl -s localhost:9192 -H "x-user-id: 12345"`{{execute}}

Example output:

```
{
  "name": "main",
  "uri": "/",
  "type": "HTTP",
  "ip_addresses": [
    "172.18.0.4"
  ],
  "start_time": "2020-10-01T16:15:47.950151",
  "end_time": "2020-10-01T16:15:47.950581",
  "duration": "430.088µs",
  "body": "Hello World",
  "code": 200
}
```

Execute the curl command multiple times, you will always be redirected to the same instance of the _backend_ service.

`docker exec client curl -s localhost:9192 -H "x-user-id: 12345"`{{execute}}

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px; margin:24px 0;">
  <p><strong>Note:</strong> sticky sessions are consistent given a stable service configuration. If the number of backend hosts changes, a fraction of the sessions will be routed to a new host after the change.
</p></div>

### Check configuration

Another way to verify the policy applied to services is to use the `consul config` command to list and inspect the configuration entries in your Consul datacenter.

`docker exec server consul config list -kind service-resolver`{{execute}}

```
backend
```

`docker exec server consul config read -kind service-resolver -name backend`{{execute}}

```
{
    "Kind": "service-resolver",
    "Name": "backend",
    "LoadBalancer": {
        "Policy": "maglev",
        "HashPolicies": [
            {
                "Field": "header",
                "FieldValue": "x-user-id"
            }
        ]
    },
    "CreateIndex": 146,
    "ModifyIndex": 662
}
```
