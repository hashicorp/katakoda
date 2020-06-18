
`helm repo add hashicorp https://helm.releases.hashicorp.com`{{execute}}


### Deploy DC1

`export KUBECONFIG=${HOME}/.shipyard/config/dc1/kubeconfig.yaml`{{execute}}

`helm install -f ./dc1-values.yml consul hashicorp/consul --timeout 10m`{{execute}}

`kubectl get pods --all-namespaces`{{execute}}

```
NAME                                                          READY   STATUS    RESTARTS   AGE
consul-connect-injector-webhook-deployment-6fd55dfcd7-5jxnm   1/1     Running   0          50s
consul-server-0                                               1/1     Running   0          49s
consul-5642w                                                  1/1     Running   0          50s
consul-mesh-gateway-bc7f449cb-7hxt6                           1/1     Running   3          50s
```

`kubectl get svc consul-mesh-gateway`{{execute}}

```
NAME                  TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)         AGE
consul-mesh-gateway   LoadBalancer   10.0.202.79   20.185.102.21   443:32753/TCP   108s
```

Once it has it, update meshGateway.wanAddress.host to that IP in your dc1-config.yaml file. In this example it would look like
```
meshGateway:
  wanAddress:
    useNodeIP: false
    host: "20.185.102.21"
```

`kubectl get secret consul-federation -o yaml > consul-federation-secret.yaml`{{execute}}

`cat consul-federation-secret.yaml | grep serverConfigJSON: | awk '{print $2}' | base64 -d`{{execute}}

### Deploy DC2

`export KUBECONFIG=${HOME}/.shipyard/config/dc2/kubeconfig.yaml`{{execute}}

`kubectl apply -f consul-federation-secret.yaml`{{execute}}

`helm install -f ./dc2-values.yml consul hashicorp/consul --timeout 10m`{{execute}}

### Deploy Service api

`export KUBECONFIG=${HOME}/.shipyard/config/dc1/kubeconfig.yaml`{{execute}}

`kubectl apply -f ~/api.yml`{{execute}}

### Deploy Service web

`export KUBECONFIG=${HOME}/.shipyard/config/dc2/kubeconfig.yaml`{{execute}}

`kubectl apply -f ~/web.yml`{{execute}}

`export IP_ADDR=$(hostname -I | awk '{print $1}')`{{execute}}

`kubectl port-forward service/web 9090:9090 --address ${IP_ADDR}`{{execute}}