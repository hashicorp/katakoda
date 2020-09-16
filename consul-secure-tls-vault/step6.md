The certificate you created manually for the Consul server had a TTL of 5 minutes.

This means that after the certificate expires consul-template will renew it and reload Consul configuration automatically to make it pick up the new files.

You can verify the rotation by checking that consul-template keeps listing, every 2 minutes, a timestamp ad the log line `Configuration reload triggered`.

You can also use `openssl` to verify the certificate content:

`openssl x509 -text -noout -in /opt/consul/agent-certs/agent.crt`{{execute T3}}

```
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            1b:2d:d6:5d:63:9b:aa:05:84:7b:be:3b:6f:e1:95:bb:1c:36:8c:a4
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN=dc1.consul Intermediate Authority
        Validity
            Not Before: Sep 16 16:03:45 2020 GMT
            Not After : Sep 16 16:06:15 2020 GMT
        Subject: CN=server.dc1.consul
...
```

and verify that the Not Before and Not After values are being updated to reflect the new certificate.
