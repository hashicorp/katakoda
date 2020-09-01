Create an intermediate CA using the root CA you generated.

Enable the `pki` secrets engine at the `pki_int` path.

```shell
vault secrets enable -path=pki_int pki
```{{execute}}

Tune the `pki_int` secrets engine to issue certificates with a maximum
time-to-live (TTL) of `43800` hours.

```shell
vault secrets tune -max-lease-ttl=43800h pki_int
```{{execute}}

Generate an intermediate certificate signing request (CSR) and save and save it
in `pki_intermediate.csr`.

```shell
vault write -format=json pki_int/intermediate/generate/internal \
        common_name="example.com Intermediate Authority" \
        | jq -r '.data.csr' > pki_intermediate.csr
```{{execute}}

Sign the intermediate CSR with the root certificate and save the generated
certificate as `intermediate.cert.pem`.

```shell
vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr \
        format=pem_bundle ttl="43800h" \
        | jq -r '.data.certificate' > intermediate.cert.pem
```{{execute}}

Import the signed certificate into Vault.

```shell
vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem
```{{execute}}
