We've created a sample application, published it to DockerHub, and created a
Kubernetes deployment that launches this application.

Open the deployment in `deployment-orgchart.yml`{{open}}.

The name of this deployment is `orgchart`. The
`spec.template.spec.serviceAccountName` defines the service account
`internal-app` to run this container.

Apply the deployment defined in `deployment-orgchart.yml`.

```shell
kubectl apply --filename deployment-orgchart.yml
```{{execute}}

Get all the pods in the default namespace.

```shell
kubectl get pods
```{{execute}}

Wait until the `orgchart` pod reports that it is running and ready (`1/1`).

Verify that **no secrets** are written to the `orgchart` container in the pod.

```shell
kubectl exec $(kubectl get pod -l app=orgchart -o jsonpath="{.items[0].metadata.name}") --container orgchart -- ls /vault/secrets
```{{execute}}

The output displays that there is no such file or directory named `/vault/secrets`.