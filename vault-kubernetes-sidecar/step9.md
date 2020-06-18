The annotations may patch these secrets into any deployment. Pods require that
the annotations be included in their intitial definition.

View the pod definition for the `payroll` application in `pod-payroll.yml`{{open}}.

Apply the pod defined in `pod-payroll.yml`.

```shell
kubectl apply --filename pod-payroll.yml
```{{execute}}

Get all the pods within the `default` namespace.

```shell
kubectl get pods
```{{execute}}

Finally, display the secret written to the `payroll` container.

```shell
kubectl exec payroll --container payroll -- cat /vault/secrets/database-config.txt
```{{execute}}

The PostgreSQL connection string is present on the container.