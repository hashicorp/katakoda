The Vault Kubernetes authentication role defined a Kubernetes service account
named `internal-app`. This service account does not yet exist.

Verify that the Kubernetes service account named `internal-app` does not exist.

```shell
kubectl get serviceaccounts
```{{execute}}

This account does not exist but it is necessary for authentication.

View the service account defined in `service-account-internal-app.yml`{{open}}.

This definition of the service account creates the account with the name
`internal-app`.

Apply the service account definition to create it.

```shell
kubectl apply --filename service-account-internal-app.yml
```{{execute}}

Verify that the service account has been created.

```shell
kubectl get serviceaccounts
```{{execute}}

The name of the service account here aligns with the name assigned to the
`bound_service_account_names` field when the `internal-app` role was created.
