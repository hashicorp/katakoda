Maintaining the annotations as a patch enables you to apply them to any
deployment. These annotations may also be defined with the deployment.

View the deployment for the `payrole` application in `deployment-04-payrole.yml`{{open}}.

Apply the deployment defined in `deployment-04-payrole.yml`.

```shell
kubectl apply --filename deployment-04-payrole.yml
```{{execute}}

Get all the pods within the `default` namespace.

```shell
kubectl get pods
```{{execute}}

Finally, display the secret written to the `payrole` container.

```shell
kubectl exec $(kubectl get pod -l app=payrole -o jsonpath="{.items[0].metadata.name}") --container payrole -- cat /vault/secrets/database-config.txt
```{{execute}}

The PostgreSQL connection string is present on the container.