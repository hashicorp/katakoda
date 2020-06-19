
Once the services are both up and running you can access them using port `9090` of the lab machine.

Open [Web frontend](https://[[HOST_SUBDOMAIN]]-9090-[[KATACODA_HOST]].environments.katacoda.com/ui) to reach service `web` interface and make sure it can reach the `api` backend.


<div style="background-color:#eff5ff; color:#416f8c; border:1px solid #d0e0ff; padding:1em; border-radius:3px; margin:24px 0;">
  <p><strong>Note:</strong>

  For this lab we deployed an ingress in your Kubernetes cluster to permit you access to the service interface without you having to manually configure it.

  You can achieve the same in a test Kubernetes environment (i.e. Minikube) by enabling port forwarding for the service:

  ```
  kubectl port-forward service/web 9090:9090 --address 0.0.0.0
  ```
</p></div>

