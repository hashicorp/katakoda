
The structure of the injected secrets may need to be structured in a way for
an application to use. Before writing the secrets to the file system a
template can structure the data. To apply this template a new set of annotations
need to be applied.

View the annotations file that contains a template definition in `patch-inject-secrets-as-template.yml`{{open}}

This patch contains two new annotations:

- `agent-inject-status` set to `update` informs the injector reinject these
  values.
- `agent-inject-template-FILEPATH` prefixes the file path. The value defines
  the [Vault Agent template](https://www.vaultproject.io/docs/agent/template/index.html)
  to apply to the secret's data.

The template formats the username and password as a PostgreSQL connection
string.

Apply the updated annotations.

```shell
kubectl patch deployment orgchart --patch "$(cat patch-inject-secrets-as-template.yml)"
```{{execute}}

Get all the pods within the `default` namespace.

```shell
kubectl get pods
```{{execute}}

Wait until the redeployment is complete and the new pod reports `READY 2/2`.

Finally, display the secret written to the `orgchart` container.

```shell
kubectl exec -it $(kubectl get pod -l app=orgchart -o jsonpath="{.items[0].metadata.name}") -c orgchart -- cat /vault/secrets/database-config.txt
```{{execute}}

The PostgreSQL connection string is present on the container.
