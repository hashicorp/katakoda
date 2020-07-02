Vault provides a Kubernetes authentication method that enables clients to
authenticate with a Kubernetes Service Account Token.

Start an interactive shell session on the `vault-0` pod.

```shell
kubectl exec -it vault-0 -- /bin/sh
```{{execute}}

Your system prompt is replaced with a new prompt `/ $`. Commands issued at this
prompt are executed on the `vault-0` container.

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

The `token_reviewer_jwt` and `kubernetes_ca_cert` reference files written to the
container by Kubernetes. The environment variable `KUBERNETES_PORT_443_TCP_ADDR`
references the internal network address of the Kubernetes host.

Create a Kubernetes authentication role named `issuer` that binds
the `pki` policy with a Kubernetes service account named `issuer`.

```shell
vault write auth/kubernetes/role/issuer \
  bound_service_account_names=issuer \
  bound_service_account_namespaces=default \
  policies=pki \
  ttl=20m
```{{execute}}

The role connects the Kubernetes service account, `issuer`, in the `default`
namespace with the `pki` Vault policy. The tokens returned after authentication
are valid for 20 minutes. This Kubernetes service account name, `issuer`, is
created in the **Deploy Issuer and Certificate** step.

Exit the `vault-0` pod.

```shell
exit
```{{execute}}