An external Vault may not have a static network address that services within the
cluster can rely upon. When Vault's network address changes each service also
needs to change to continue its operation. Another approach to manage this
network address is to define a Kubernetes service and endpoints.

A _service_ creates an abstraction around pods or an external service. When an
application running in a pod requests the service, that request is routed to the
endpoints that share the service name.

Deploy a service named `external-vault` and a corresponding endpoint configured
to address the `EXTERNAL_VAULT_ADDR`.

```shell
cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Service
metadata:
  name: external-vault
  namespace: default
spec:
  ports:
  - protocol: TCP
    port: 8200
---
apiVersion: v1
kind: Endpoints
metadata:
  name: external-vault
subsets:
  - addresses:
      - ip: $EXTERNAL_VAULT_ADDR
    ports:
      - port: 8200
EOF
```{{execute}}

Verify that the `external-vault` service is addressable from within the
`devwebapp` pod.

```shell
kubectl exec \
  $(kubectl get pod -l app=devwebapp -o jsonpath="{.items[0].metadata.name}") \
  -- curl -s http://external-vault:8200/v1/sys/seal-status | jq
```{{execute}}

The `devwebapp` pod is able to reach the Vault server through the
`external-vault` service.

Open the deployment in `deployment-01-external-vault-service.yml`{{open}}

This deployment sets the `VAULT_ADDR` to the the `external-vault` service.

Next, apply the deployment defined in `deployment-01-external-vault-service.yml`.

```shell
kubectl apply -f deployment-01-external-vault-service.yml
```{{execute}}

This deployment named `devwebapp-through-service` creates a pod that addresses
Vault through the service instead of the hard-coded network address.

Get all the pods within the default namespace.

```shell
kubectl get pods
```{{execute}}

Wait until the `devwebapp-through-service` pod is running and ready (`1/1`).

Finally, request content served at `localhost:8080` from within the
`devwebapp-through-service` pod.

```shell
kubectl exec \
  $(kubectl get pod -l app=devwebapp-through-service -o jsonpath="{.items[0].metadata.name}") \
  -- curl -s localhost:8080
```{{execute}}

The web application authenticates and requests the secret from the external
Vault server that it found through the `external-vault` service.