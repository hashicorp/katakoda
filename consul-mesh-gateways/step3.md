Now you're ready to import the secret into your secondary cluster(s).

Switch kubectl context to your secondary Kubernetes cluster.

`export KUBECONFIG=${HOME}/.shipyard/config/dc2/kubeconfig.yaml`{{execute}}

And import the secret:

`kubectl apply -f consul-federation-secret.yaml`{{execute}}


### Deploy consul secondary datacenter (`dc2`)

With the primary cluster up and running, and the federation secret imported into the secondary cluster, you can now install Consul into the secondary cluster.

This hands-on lab comes with a prepared configuration.

`cat dc2-values.yml | more`{{execute}}

<div style="background-color:#eff5ff; color:#416f8c; border:1px solid #d0e0ff; padding:1em; border-radius:3px; margin:24px 0;">
  <p><strong>Info: </strong>

  You must use a separate Helm config file for each datacenter (primary and secondaries) since their settings are different.

</p></div>

You will use `helm install` to deploy Consul using the configuration defined in `dc2-values.yml`. This should only take a few minutes.

`helm install -f ./dc2-values.yml consul hashicorp/consul --version "0.22.0" --timeout 10m`{{execute}}

