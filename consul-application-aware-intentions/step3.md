
Once you verified connectivity between `web` and `api` next step is to expose your web interface outside the mesh using the ingress gateway.

You do not want to expose the root (`/health`) path outside the mesh because, being used to monitor the health of the service, it reveals details about the infrastructure state externally.

Consul 1.9.0, with the `service-intention` config entry introduction also implemented a more powerful implementation of intentions for `http` services.

Some intentions may additionally enforce access based on L7 request attributes in addition to connection identity. These may only be defined for services with a protocol that is HTTP-based. 

The lab provides you a file, named `config-intentions-web.hcl`, with the following content:

```hcl
Kind = "service-intentions"
Name = "web"
Sources = [
  {
    Name = "ingress-service"
    Permissions = [
      {
        Action = "allow"
        HTTP {
          PathExact = "/ui"
          Methods   = ["GET"]
        }
      }
      {
        Action = "deny"
        HTTP {
          PathExact = "/health"
          Methods   = ["GET"]
        }
      }
    ]
  },
  # NOTE: a default catch-all based on the default ACL policy will apply to
  # unmatched connections and requests. Typically this will be DENY.
]
```

This configuration entry defines an intention for service `web` allowing GET http requests on `/ui` path and denying those on `/health` started from service `ingress-service`, that is the service we configured as the ingress service representing `web` outside the mesh.

<div style="background-color:#eff5ff; color:#416f8c; border:1px solid #d0e0ff; padding:1em; border-radius:3px; margin:24px 0;">
  <p><strong>Info:</strong> This intention is application aware and performs extra filtering on L7 attributes. These intentions are applicable only to http service types. Tcp services are not allowed to be defined as destination for an application aware intention. 
</p></div>

Once you reviewed the fle, apply the configuration with:

`consul config write config-intentions-web.hcl`{{execute}}

Example output:

```plaintext
Config entry written: service-intentions/web
```

### Verify service connectivity

If you [open the ingress gateway](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/ui) yous should be able to verify that the connection is now permitted.

And you can verify the `/health` endpoint is actually denied:

`curl --silent web.ingress.consul:8080/health`{{execute}}

Example Output

```
RBAC: access denied
```