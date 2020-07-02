Start an interactive shell session on the `vault-0` pod.

```shell
kubectl exec -it vault-0 -- /bin/sh
```{{execute}}

Your system prompt is replaced with a new prompt `/ $`. Commands issued at this
prompt are executed on the `vault-0` container.

Enable the PKI secrets engine at its default path.

```shell
vault secrets enable pki
```{{execute}}

By default the KPI secrets engine sets the time-to-live (TTL) to 30 days. A
certificate can have its lease extended to ensure certificate rotation on a
yearly basis (8760h).

Configure the max lease time-to-live (TTL) to `8760h`.

```shell
vault secrets tune -max-lease-ttl=8760h pki
```{{execute}}

Vault can accept an existing key pair, or it can generate its own self-signed
root. In general, we recommend maintaining your root CA outside of Vault and
providing Vault a signed intermediate CA.

Generate a self-signed certificate valid for `8760h`.

```shell
vault write pki/root/generate/internal \
  common_name=example.com \
  ttl=8760h
```{{execute}}

Configure the PKI secrets engine certificate issuing and certificate revocation
list (CRL) endpoints to use the Vault service in the default namespace.

```shell
vault write pki/config/urls \
  issuing_certificates="http://vault.default:8200/v1/pki/ca" \
  crl_distribution_points="http://vault.default:8200/v1/pki/crl"
```{{execute}}

Configure a role named `example-dot-com` that enables the creation of
certificates `example.com` domain with any subdomains.

```shell
vault write pki/roles/example-dot-com \
  allowed_domains=example.com \
  allow_subdomains=true \
  max_ttl=72h
```{{execute}}

The role, `example-dot-com`, is a logical name that maps to a policy used to
generate credentials. This generates a number of endpoints that are used by the
Kubernetes service account to issue and sign these certificates. A policy must
be created that enables these paths.

Create a policy named `pki` that enables read access to the PKI secrets engine
paths.

```shell
vault policy write pki - <<EOF
path "pki*"                        { capabilities = ["read", "list"] }
path "pki/roles/example-dot-com"   { capabilities = ["create", "update"] }
path "pki/sign/example-dot-com"    { capabilities = ["create", "update"] }
path "pki/issue/example-dot-com"   { capabilities = ["create"] }
EOF
```{{execute}}

These paths enable the token to view all the roles created for this PKI secrets
engine and access the `sign` and `issues` operations for the `example-dot-com`
role.

Exit the `vault-0` pod.

```shell
exit
```{{execute}}