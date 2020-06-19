
Once the Kubernetes cluster is running, you can deploy Consul service mesh on it. In this hands-on lab you are going to use Helm for the deploy.

#### Add HashiCorp repository to Helm

You can add the official HashiCorp Consul Helm chart repo directly from the command line.

`helm repo add hashicorp https://helm.releases.hashicorp.com`{{execute}}

The chart helps you automate the installation and configuration of Consul’s core features for Kubernetes.

Ensure you have access to the Consul chart after the add:

`helm search repo hashicorp/consul`{{execute}}

Example output:

```
NAME                    CHART VERSION   APP VERSION     DESCRIPTION
hashicorp/consul        0.22.0          1.8.0           Official HashiCorp Consul Chart
```

#### Configure Consul service mesh

The Helm chart has no required configuration and will install a Consul datacenter with reasonable defaults out of the box. This is a good way to test the installation on a dev environment but real-life scenarios require customization to adapt the deployment to your needs.

If you want to customize your installation, you can create a `.yaml` file to override the default settings and use it as a parameter for the intallation command. 

This hands-on lab comes with a prepared configuration file.

`consul-values.yml`{{open}}

Note the following settings:

* The `global` section is used to define settings applying to the entire Consul datacenter. In the example configuration the datacenter name is set to *minidc*. Feel free to change that value before the deploy if you want to change your datacenter name.
* The `server` key contains parameters related to the server pods. The chart is configured to create one Consul server per Kubernetes node.
* The Consul service mesh is enabled by setting the `connectInject` key to true. When the service mesh connect injector is installed, then a sidecar proxy is automatically added to all pods.
* The `ui` section enables Consul web UI.

<div style="background-color:#eff5ff; color:#416f8c; border:1px solid #d0e0ff; padding:1em; border-radius:3px; margin:24px 0;">
  <p><strong>Info: </strong>

The example in this lab modifies only a few default settings.  You can learn what settings are available by running `helm inspect values hashicorp/consul` or by reading the [Helm Chart Reference](https://www.consul.io/docs/k8s/helm) available on the Consul documentation site.

</p></div>


#### Deploy Consul with Helm

You will use `helm install` to deploy Consul using the configuration defined in `consul-values.yml`. This should only take a few minutes.

`helm install -f ~/consul-values.yml hashicorp hashicorp/consul`{{execute}}

#### Verify the Consul deployment

Once the command terminates all components for Consul service mesh should be installed and initializing in your Kubernetes cluster.

Execute `kubectl get services` from the command line to verify the services, including Consul, are present in the Kubernetes cluster.

`kubectl get services`{{execute}}

You should have the following four Consul services available:

* hashicorp-consul-server
* hashicorp-consul-connect-injector-svc
* hashicorp-consul-dns
* hashicorp-consul-ui
