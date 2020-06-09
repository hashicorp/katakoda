We've created a sample application, published it to DockerHub, and created a
Kubernetes deployment that launches this application.

View the deployment for the `orgchart` application in
`deployment-01-orgchart.yml`{{open}}.

The name of this deployment is `orgchart`. The
`spec.template.spec.serviceAccountName` defines the service account
`internal-app` to run this container.

Apply the deployment defined in `deployment-01-orgchart.yml`.

```shell
kubectl apply --filename deployment-01-orgchart.yml
```{{execute}}

The application runs as a pod within the `default` namespace.

Get all the pods within the `default` namespace.

```shell
kubectl get pods
```{{execute}}

The orgchart pod is displayed here as the pod prefixed with `orgchart`.


Wait until the `orgchart` pod status becomes **Running** and Ready (`1/1`).

Verify that no secrets are written to the `orgchart` container in the pod.

```shell
kubectl exec $(kubectl get pod -l app=orgchart -o jsonpath="{.items[0].metadata.name}") --container orgchart -- ls /vault/secrets
```{{execute}}

The output displays that there is no such file or directory named `/vault/secrets`.