Applications on pods can remain Vault unaware if they provide deployment
annotations that the Vault Agent Injector detects. This injector service
leverages the Kubernetes mutating admission webhook to intercept pods that
define specific annotations and inject a Vault Agent container to manage these
secrets. An application needs:

- a service account
- a Vault secret
- a Vault policy to read the secret
- a Kubernetes authentication role
- a deployment with Vault Agent Injector annotations

### Create the service account

Open the service account defined in `service-account-issues.yml`{{open}}.

This definition of the service account creates the account with the name
`issues`.

Apply the service account.

```shell
oc apply --filename service-account-issues.yml
```{{execute}}

Get all the service accounts within the default namespace.

```shell
oc get serviceaccounts
```{{execute}}

The `issues` service account is displayed.

### Create the secret

Start an interactive shell session on the `vault-0` pod.

```shell
oc exec -it vault-0 -- /bin/sh
```{{execute}}

Your system prompt is replaced with a new prompt `/ #`. Commands issued at this
prompt are executed on the `vault-0` container.

Create a secret at path `secret/issues/config` with a `username` and `password`.

```shell
vault kv put secret/issues/config username="annotation-user" password="annotation-password"
```{{execute}}

Get the secret at path `secret/issues/config`.

```shell
vault kv get secret/issues/config
```{{execute}}

The secret with the username and password is displayed.

### Define the read policy

Write out the policy named `issues` that enables the `read` capability for
secrets at path `secret/data/issues/config`.

```shell
vault policy write issues - <<EOF
path "secret/data/issues/config" {
  capabilities = ["read"]
}
EOF
```{{execute}}

The policy `issues` is used in the Kubernetes authentication role definition.

### Create a Kubernetes authentication role

Create a Kubernetes authentication role, named `issues`, that connects the
Kubernetes service account name and `issues` policy.

```shell
vault write auth/kubernetes/role/issues \
  bound_service_account_names=issues \
  bound_service_account_namespaces=default \
  policies=issues \
  ttl=24h
```{{execute}}

The role connects the Kubernetes service account, `issues`, the namespace,
`default`, with the Vault policy, `issues`. The tokens returned are valid for 24
hours.

Exit the `vault-0` pod.

```shell
exit
```{{execute}}

### Deploy the application

Open the issues deployment defined in `deployment-issues.yml`{{open}}.

The Vault Agent Injector service reads the metadata annotations prefixed with
`vault.hashicorp.com`.

- `agent-inject` enables the Vault Agent injector service
- `role` is the Vault Kubernetes authentication role
- `agent-inject-secret-FILEPATH` prefixes the path of the file,
  `issues-config.txt` written to the `/vault/secrets` directory. The value
  is the path to the Vault secret.
- `agent-inject-template-FILEPATH` formats the secret with a provided template.

Apply the issues deployment.

```shell
oc apply --filename deployment-issues.yml
```{{execute}}

Display all the pods within the default namespace.

```shell
oc get pods
```{{execute}}

Wait until the `issues` pod is running and ready (`2/2`).

This new pod now launches two containers. The application container, named
`issues`, and the Vault Agent container, named `vault-agent`.

Display the logs of the `vault-agent` container in the `issues` pod.

```shell
oc logs \
  $(oc get pod -l app=issues -o jsonpath="{.items[0].metadata.name}") \
  --container vault-agent
```{{execute}}

Display the secret written to the `issues` container.

```shell
oc exec \
  $(oc get pod -l app=issues -o jsonpath="{.items[0].metadata.name}") \
  --container issues -- cat /vault/secrets/issues-config.txt ; echo
```{{execute}}

The secrets are rendered in a PostgreSQL connection string is present on the
container.
