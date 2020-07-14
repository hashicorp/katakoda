Applications on pods can directly communicate with Vault to authenticate and
request secrets. An application needs:

- a service account
- a Vault secret
- a Vault policy to read the secret
- a Kubernetes authentication role

### Create the service account

Open the service account defined in `service-account-webapp.yml`{{open}}.

This definition of the service account creates the account with the name
`webapp`.

Apply the service account.

```shell
oc apply --filename service-account-webapp.yml
```{{execute}}

Get all the service accounts within the default namespace.

```shell
oc get serviceaccounts
```{{execute}}

The `webapp` service account is displayed.

### Create the secret

Start an interactive shell session on the `vault-0` pod.

```shell
oc exec -it vault-0 -- /bin/sh
```{{execute}}

Your system prompt is replaced with a new prompt `/ #`. Commands issued at this
prompt are executed on the `vault-0` container.

Create a secret at path `secret/webapp/config` with a `username` and `password`.

```shell
vault kv put secret/webapp/config username="static-user" password="static-password"
```{{execute}}

Get the secret at path `secret/webapp/config`.

```shell
vault kv get secret/webapp/config
```{{execute}}

The secret with the username and password is displayed.

### Define the read policy

Write out the policy named `webapp` that enables the `read` capability for
secrets at path `secret/data/webapp/config`.

```shell
vault policy write webapp - <<EOF
path "secret/data/webapp/config" {
  capabilities = ["read"]
}
EOF
```{{execute}}

The policy `webapp` is used in the Kubernetes authentication role definition.

### Create a Kubernetes authentication role

Create a Kubernetes authentication role, named `webapp`, that connects the
Kubernetes service account name and `webapp` policy.

```shell
vault write auth/kubernetes/role/webapp \
  bound_service_account_names=webapp \
  bound_service_account_namespaces=default \
  policies=webapp \
  ttl=24h
```{{execute}}

The role connects the Kubernetes service account, `webapp`, the namespace,
`default`, with the Vault policy, `webapp`. The tokens returned are valid for 24
hours.

Exit the `vault-0` pod.

```shell
exit
```{{execute}}

### Deploy the application

Open the webapp deployment defined in `deployment-webapp.yml`{{open}}.

The deployment deploys a pod with a web application running under the `webapp`
service account that talks directly to the Vault service created by the Vault
Helm chart `http://vault:8200`.

Apply the webapp deployment.

```shell
oc apply --filename deployment-webapp.yml
```{{execute}}

Display all the pods within the default namespace.

```shell
oc get pods
```{{execute}}

Wait until the `webapp` pod is running and ready (`1/1`).

This web application runs an HTTP service that listens on port 8080.

Perform a `curl` request at `http://localhost:8080` on the `webapp` pod.

```shell
oc exec \
  $(oc get pod -l app=webapp -o jsonpath="{.items[0].metadata.name}") \
  --container app -- curl -s http://localhost:8080 ; echo
```{{execute}}

The web application running on port 8080 in the _webapp_ pod:

- authenticates with the Kubernetes service account token
- receives a Vault token with the read capability at the
  `secret/data/webapp/config` path
- retrieves the secrets from `secret/data/webapp/config` path
- displays the secrets as JSON
