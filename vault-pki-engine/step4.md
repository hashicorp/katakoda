Request a new certificate for the `test.example.com` domain based on the
`example-dot-com` role.

```shell
vault write pki_int/issue/example-dot-com common_name="test.example.com" ttl="24h"
```{{execute}}

The response displays the PEM-encoded private key, key type and certificate
serial number.
