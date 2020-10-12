The default load balancing policy, *round_robin*, is usually the best approach in scenarios where requests are homogeneous and the system is over-provisioned.

In scenarios where the different instances might be subject to substantial differences in terms of workload there are better approaches.

Using the *least_request* policy permits Envoy sidecar proxies to resolve requests using information on instance load level and select the one with the lowest load.

### Configure least_request load balancing policy

The lab provides an example configuration file, `least-req-resolver.hcl`{{open}} for *least_request* policy.

```
Kind           = "service-resolver"
Name           = "backend"
LoadBalancer = {
  Policy = "least_request"
  LeastRequestConfig = {
    ChoiceCount = "2"
  }
}
```

This configuration creates a `service-resolver` load balancing policy, for every request to the `backend` service 2 (as expressed by `ChoiceCount`) random instances of that service are selected and the traffic is routed to the one with the least amount of load.

You can apply the policy using the `consul config` command.

`docker exec server consul config write /etc/consul.d/least-req-resolver.hcl`{{execute}}

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
  "start_time": "2020-10-01T16:25:47.950151",
  "end_time": "2020-10-01T16:25:47.950581",
  "duration": "420.066µs",
  "body": "Hello World",
  "code": 200
}
```

Execute the command multiple times to verify that, despite the user id in the header, the request gets served by different instances of the service.

`docker exec client curl -s localhost:9192 -H "x-user-id: 12345"`{{execute}}

<div style="background-color:#eff5ff; color:#416f8c; border:1px solid #d0e0ff; padding:1em; border-radius:3px; margin:24px 0;">
  <p><strong>Info:</strong><br>
  
  The least_request configuration with `ChoiceCount` set to 2 is also known as P2C (power of two choices). The P2C load balancer has the property that a host with the highest number of active requests in the cluster will never receive new requests. It will be allowed to drain until it is less than or equal to all of the other hosts. You can read more on this on [this paper](https://www.eecs.harvard.edu/~michaelm/postscripts/handbook2001.pdf)

</p></div>
