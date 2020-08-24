Generate a self-signed certificate authority (CA) root certificate using PKI
secrets engine.

Enable the `pki` secrets engine at the `pki` path.

```shell
vault secrets enable pki
```{{execute}}

Tune the `pki` secrets engine to issue certificates with a maximum time-to-live
(TTL) of `87600` hours.

```shell
vault secrets tune -max-lease-ttl=87600h pki
```{{execute}}

Generate the **_root_** certificate and save the certificate in `CA_cert.crt`.

```shell
vault write -field=certificate pki/root/generate/internal \
  common_name="example.com" \
  ttl=87600h > CA_cert.crt
```{{execute}}

This generates a new self-signed CA certificate and private key. Vault
_automatically_ revokes the generated root at the end of its lease period (TTL);
the CA certificate will sign its own Certificate Revocation List (CRL).

Configure the CA and CRL URL.

```shell
vault write pki/config/urls \
  issuing_certificates="http://127.0.0.1:8200/v1/pki/ca" \
  crl_distribution_points="http://127.0.0.1:8200/v1/pki/crl"
```{{execute}}
