Vault provides a Kubernetes authentication method that enables clients to
authenticate with a Kubernetes Service Account Token. This token is provided to
each pod when it is created.

Start an interactive shell session on the `vault-0` pod.

```shell
kubectl exec -it vault-0 -- /bin/sh
```{{execute}}

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

Write out the policy named `internal-app` that enables the `read` capability
for secrets at path `internal/data/database/config`.

```shell
vault policy write internal-app - <<EOF
path "internal/data/database/config" {
  capabilities = ["read"]
}
EOF
```{{execute}}

Create a Kubernetes authentication role named `internal-app`.

```shell
vault write auth/kubernetes/role/internal-app \
        bound_service_account_names=internal-app \
        bound_service_account_namespaces=default \
        policies=internal-app \
        ttl=24h
```{{execute}}

The role connects the Kubernetes service account, `internal-app`, and namespace,
`default`, with the Vault policy, `internal-app`. The tokens returned after
authentication are valid for 24 hours.

Exit the `vault-0` pod.

```shell
exit
```{{execute}}