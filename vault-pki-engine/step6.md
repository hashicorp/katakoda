Remove revoked certificate and clean the Certificate Revocation List (CRL).

```shell
vault write pki_int/tidy tidy_cert_store=true tidy_revoked_certs=true
```{{execute}}