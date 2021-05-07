Vault provides a Kubernetes authentication method that enables clients to
authenticate with a Kubernetes Service Account Token.

Start an interactive shell session on the `vault-0` pod.

```shell
kubectl exec -it vault-0 -- /bin/sh
```{{execute}}

Your system prompt is replaced with a new prompt `/ $`.

Enable the Kubernetes authentication method.

```shell
vault auth enable kubernetes
```{{execute}}

Configure the Kubernetes authentication method to use the service account
token, the location of the Kubernetes host, and its certificate.

```shell
vault write auth/kubernetes/config \
    issuer="https://kubernetes.default.svc.cluster.local" \
    token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
    kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
    kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
```{{execute}}

The data of
[kv-v2](https://www.vaultproject.io/api-docs/secret/kv/kv-v2) requires that
an additional path element of `data` is included after its mount path (in this
case, `secret/`).

Write out the policy named `internal-app`.

```shell
vault policy write internal-app - <<EOF
path "secret/data/db-pass" {
  capabilities = ["read"]
}
EOF
```{{execute}}

Create a Kubernetes authentication role named `database`.

```shell
vault write auth/kubernetes/role/database \
    bound_service_account_names=webapp-sa \
    bound_service_account_namespaces=default \
    policies=internal-app \
    ttl=20m
```{{execute}}

The role connects the Kubernetes service account, `webapp-sa`, in
the namespace, `default`, with the Vault policy, `internal-app`. The tokens
returned after authentication are valid for 20 minutes. This Kubernetes service
account name, `webapp-sa`, will be created below.

Exit the `vault-0` pod.

```shell
exit
```{{execute}}