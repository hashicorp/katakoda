Vault provides a [Kubernetes
authentication](https://www.vaultproject.io/docs/auth/kubernetes.html) method
that enables clients to authenticate with a Kubernetes Service Account
Token.

Enable the Kubernetes authentication method.

```shell
vault auth enable kubernetes
```{{execute}}

Configure the Kubernetes authentication method to use the service account
token, the location of the Kubernetes host, and its certificate.

```shell
vault write auth/kubernetes/config \
        token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
        kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
        kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
```{{execute}}

Write out the policy named `webapp` that enables the `read` capability for
secrets at path `secret/data/webapp/config`.

```shell
vault policy write webapp - <<EOF
path "secret/data/webapp/config" {
  capabilities = ["read"]
}
EOF
```{{execute}}

Create a Kubernetes authentication role, named `webapp`, that connects the
Kubernetes service account name and `webapp` policy.

```shell
vault write auth/kubernetes/role/webapp \
        bound_service_account_names=vault \
        bound_service_account_namespaces=default \
        policies=webapp \
        ttl=24h
```{{execute}}

The role connects the Kubernetes service account, `vault`, and namespace,
`default`, with the Vault policy, `webapp`. The tokens returned after
authentication are valid for 24 hours.

Lastly, exit the `vault-0` pod.

```shell
exit
```{{execute}}