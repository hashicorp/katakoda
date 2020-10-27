You can use The [intention match API](https://www.consul.io/api/connect/intentions#list-matching-intentions) should be periodically called to retrieve all relevant intentions for the target destination.

For example the following command retrieves all intentions that have `web` as their source:

`curl --silent "http://consul.service.dc1.consul:8500/v1/connect/intentions/match?by=source&name=web" | jq`{{execute}}

```json
{
  "web": [
    {
      "SourceNS": "default",
      "SourceName": "web",
      "DestinationNS": "default",
      "DestinationName": "api",
      "SourceType": "consul",
      "Action": "allow",
      "Precedence": 9,
      "CreateIndex": 60,
      "ModifyIndex": 61
    },
    {
      "SourceNS": "default",
      "SourceName": "*",
      "DestinationNS": "default",
      "DestinationName": "*",
      "SourceType": "consul",
      "Action": "deny",
      "Precedence": 5,
      "CreateIndex": 49,
      "ModifyIndex": 49
    }
  ]
}
```

When configuring intentions for your datacenter remember that the default intention behavior is defined by the default ACL policy. If the default ACL policy is "allow all", then all connections are allowed by default. If the default ACL policy is "deny all", then all connections or requests are denied by default.