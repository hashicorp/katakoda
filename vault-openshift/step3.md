Vault provides a Kubernetes authentication method that enables clients to
authenticate with Vault within a OpenShift cluster. This authentication method
configuration requires the location of the Kubernetes host, a JSON web token,
and a certificate to prove authenticity. These values are available an
environment variable and files and on the Vault pod.

Start an interactive shell session on the `vault-0` pod.

```shell
oc exec -it vault-0 -- /bin/sh
```{{execute}}

Your system prompt is replaced with a new prompt `/ #`. Commands issued at this
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

The authentication method is now configured.

Exit the `vault-0` pod.

```shell
exit
```{{execute}}