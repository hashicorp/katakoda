The annotations may patch deployments but pods require that the annotations be
included in their intitial definition.

Open the pod definition in `pod-payroll.yml`{{open}}.

The name of this pod is `payroll`. The `spec.template.spec.serviceAccountName`
defines the service account `internal-app` to run this container. The
annotations are defined with the pod.

Apply the pod defined in `pod-payroll.yml`.

```shell
kubectl apply --filename pod-payroll.yml
```{{execute}}

Get all the pods within the default namespace.

```shell
kubectl get pods
```{{execute}}

Wait until the `payroll` pod is running and ready (`2/2`).

Display the secret written to the `payroll` container.

```shell
kubectl exec payroll --container payroll -- cat /vault/secrets/database-config.txt
```{{execute}}

The secrets are rendered in a PostgreSQL connection string.