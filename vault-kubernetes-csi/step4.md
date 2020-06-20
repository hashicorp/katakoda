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
  token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
  kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
  kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
```{{execute}}

For the Kubernetes-Secrets-Store-CSI-Driver to read the secrets requires that it
has read permissions of all mounts and access to the secret itself.

Write out the policy named `internal-app-csi`.

```shell
vault policy write internal-app-csi - <<EOF
path "sys/mounts" {
  capabilities = ["read"]
}

path "secret/data/db-pass" {
  capabilities = ["read"]
}
EOF
```{{execute}}

Create a Kubernetes authentication role named `database`.

```shell
vault write auth/kubernetes/role/database \
    bound_service_account_names=secrets-store-csi-driver \
    bound_service_account_namespaces=default \
    policies=internal-app-csi \
    ttl=20m
```{{execute}}

The role connects the Kubernetes service account, `secrets-store-csi-driver`,
and namespace, `default`, with the Vault policy, `internal-app-csi`. The tokens
returned after authentication are valid for 20 minutes.

Exit the `vault-0` pod.

```shell
exit
```{{execute}}