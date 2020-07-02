Create a service account, secret, and ClusterRoleBinding with the neccessary
permissions to allow Vault to perform token reviews with Kubernetes.

```shell
cat <<EOF | kubectl create -f -
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: vault-auth
---
apiVersion: v1
kind: Secret
metadata:
  name: vault-auth
  annotations:
    kubernetes.io/service-account.name: vault-auth
type: kubernetes.io/service-account-token
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: role-tokenreview-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: system:auth-delegator
subjects:
  - kind: ServiceAccount
    name: vault-auth
    namespace: default
EOF
```{{execute}}

This creates the `vault-auth` service account, the `vault-auth` secret, and
the *ClusterRoleBinding* that uses the created service account.

Vault provides a [Kubernetes
authentication](https://www.vaultproject.io/docs/auth/kubernetes.html) method
that enables clients to authenticate with a Kubernetes Service Account
Token.

Enable the Kubernetes authentication method.

```shell
vault auth enable kubernetes
```{{execute}}

Vault accepts this service token from any client within the Kubernetes cluster.
During authentication, Vault verifies that the service account token is valid by
querying a configured Kubernetes endpoint. To configure it correctly requires
capturing the JSON web token (JWT) for the service account, the Kubernetes CA
certificate, and the Kubernetes host URL.

First, get the JSON web token (JWT) for this service account.

```shell
TOKEN_REVIEW_JWT=$(kubectl get secret vault-auth -o go-template='{{ .data.token }}' | base64 --decode)
```{{execute}}

Next, retrieve the Kubernetes CA certificate.

```shell
KUBE_CA_CERT=$(kubectl config view --raw --minify --flatten -o jsonpath='{.clusters[].cluster.certificate-authority-data}' | base64 --decode)
```{{execute}}

Next, retrieve the Kubernetes host URL.

```shell
KUBE_HOST=$(kubectl config view --raw --minify --flatten -o jsonpath='{.clusters[].cluster.server}')
```{{execute}}

Finally, configure the Kubernetes authentication method to use the service
account token, the location of the Kubernetes host, and its certificate.

```shell
vault write auth/kubernetes/config \
  token_reviewer_jwt="$TOKEN_REVIEW_JWT" \
  kubernetes_host="$KUBE_HOST" \
  kubernetes_ca_cert="$KUBE_CA_CERT"
```{{execute}}

For a Vault client to read the secret data defined in the [Start
Vault](#start-vault) section requires that the read capability be granted for
the path `secret/data/devwebapp/config`.

Write out the policy named `devwebapp` that enables the `read` capability
for secrets at path `secret/data/devwebapp/config`

```shell
vault policy write devwebapp - <<EOF
path "secret/data/devwebapp/config" {
  capabilities = ["read"]
}
EOF
```{{execute}}

Create a Kubernetes authentication role named `devweb-app`.

```shell
vault write auth/kubernetes/role/devweb-app \
  bound_service_account_names=internal-app \
  bound_service_account_namespaces=default \
  policies=devwebapp \
  ttl=24h
```{{execute}}

The role connects the Kubernetes service account, `internal-app`, and namespace,
`default`, with the Vault policy, `devwebapp`. The tokens returned after
authentication are valid for 24 hours.

The Vault Helm chart is able to install only the Vault Agent Injector service.

Add the HashiCorp Helm repository.

```shell
helm repo add hashicorp https://helm.releases.hashicorp.com
```{{execute}}

Install the latest version of the Vault server running in external mode.

```shell
helm install vault hashicorp/vault --set "injector.externalVaultAddr=http://external-vault:8200"
```{{execute}}

The Vault Agent Injector pod is deployed in the default namespace.

Get all the pods in the default namespace.

```shell
kubectl get pods
```{{execute}}

Wait until the `vault-agent-injector` pod reports that it is running and ready
(`1/1`).