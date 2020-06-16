#### Wait until all pods are running

In order to access Consul you must verify the deploy was completed. Execute the following command, and review the output.

`kubectl get pods --all-namespaces`{{execute}}

If the output shows all the pods in a `Running` state you can now configure your Kubernetes cluster to be accessed from outside.

#### Configure port forwarding for the Consul UI

To access the Consul UI you will setup port forwarding.

`export IP_ADDR=$(hostname -I | awk '{print $1}')`{{execute}}

`kubectl port-forward service/hashicorp-consul-ui 80:80 --address ${IP_ADDR}`{{execute}}

This will forward port `80` from `service/hashicorp-consul-ui` at port `80` to your test machine.

You can now open the Consul UI tab to be redirected to the Consul UI. The Consul UI will list
the `consul` service.



