## curl for Nomad TLS config

```
curl --cert $NOMAD_CLIENT_CERT --cert-type PEM \
     --key $NOMAD_CLIENT_KEY --key-type PEM \
     --cacert $NOMAD_CAPATH \
     https://127.0.0.1:4646/v1/jobs
```
