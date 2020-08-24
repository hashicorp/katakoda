Create a role named `example-dot-com` which allows subdomains.

```shell
vault write pki_int/roles/example-dot-com \
  allowed_domains="example.com" \
  allow_subdomains=true \
  max_ttl="720h"
```{{execute}}
