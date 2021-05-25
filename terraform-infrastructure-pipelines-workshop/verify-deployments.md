## Verify deployments

Now that you have deployed a Vault instance using Consul as a backend on a GKE
cluster, you will connect to your Kubernetes cluster using `kubectl` to access
the respective instances.

You will do this in Katacoda, using the editor and terminal you see on the
right.

## Login with the Terraform CLI

First, login to Terraform Cloud using the CLI.

`terraform login`{{execute T1}} 

The command output will ask you if you want to confirm that you want to generate
a token and store it. Confirm when it prompts you.

`yes`{{execute}}

Terraform will prompt you to visit a [link to Terraform
Cloud](https://app.terraform.io/app/settings/tokens?source=terraform-login) in
the output. Visit that page now.

In Terraform Cloud, click the "Create API token" button. Terraform Cloud will
generate an API token and display it.

Copy the API token from Terraform Cloud and paste it into your Katacoda terminal
where prompted (`Token for app.terraform.io:`).

**Note:** You can paste into the Katacoda terminal window as you normally would,
but the terminal will not display the token, so be sure to only paste your token
once.

Press Enter to confirm. If needed, you can re-run the `terraform login`
command until the token is accepted.

## Configure kubectl

Open `main.tf`{{open}} in your Katacoda editor window. The file will be empty.

Add the following configuration to this file.

<pre class="file" data-filename="main.tf" data-target="replace">
terraform {
  backend "remote" {
    organization = "infrastructure-pipelines-workshop"

    workspaces {
      name = "john-d-k8s"
    }
  }
}
</pre>

Replace the workspace name with the name of your Kubernetes workspace.
  - `name = "{firstName}-{lastInitial}-k8s"`

You do not need to save this file; Katacoda will automatically save it when you
edit it.

This will establish a connection to your Kubernetes workspace. 

Now initialize your Terraform workspace.  

`terraform init`{{execute T1}}

Save your Kubernetes workspace's `kubeconfig` output value into a file named
`kubeconfig`. This will allow you to connect to your Kubernetes cluster.

`terraform output -raw kubeconfig > kubeconfig`{{execute T1}}

Check the number of nodes in your Kubernetes deployment.

`kubectl --kubeconfig=kubeconfig --token $(terraform output -raw access_token) get nodes`{{execute T1}}

Since Vault and Consul are enabled, you will see 5 nodes.

Check the Kubernetes cluster pods. You will see pods for both Consul and
Vault.

`kubectl --kubeconfig=kubeconfig --token $(terraform output -raw access_token) -n hashicorp-learn get pods`{{execute T1}}


## Access Consul UI

Forward port :8500 (Consul UI) on your Consul server to port :8500 in your
Katacoda environment, allowing you to access it from within Katacoda.

`kubectl --kubeconfig=kubeconfig --token $(terraform output -raw access_token) -n hashicorp-learn port-forward --address 0.0.0.0 consul-server-0 8500:8500`{{execute T1}}

Click on the "Consul UI" tab in your terminal pane or visit
`https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com` in
your browser to access the Consul UI.

> **Note:** The Consul UI does not show Vault in the list of services because
  its service_registration stanza in the Helm chart defaults to Kubernetes.
  However, Vault is still configured to use Consul as a backend.

## Access Vault UI

Open a new tab in the Katacoda terminal pane by using the "+" symbol and
selecting "Open New Terminal".

In this new tab, forward port :8200 (Vault UI) on your Vault server to port
:8200 in your Katacoda environment, allowing you to access it from withing
Katacoda.

`kubectl --kubeconfig=kubeconfig --token $(terraform output -raw access_token) -n hashicorp-learn port-forward --address 0.0.0.0 hashicorp-learn-vault-0 8200:8200`{{execute T2}}

Click on the "Vault UI" tab in the Katacoda terminal pane or visit
`https://[[HOST_SUBDOMAIN]]-8200-[[KATACODA_HOST]].environments.katacoda.com` in
your browser to access the Vault UI.

> **Note:** The Vault pods have warnings because Vault is sealed. There is no
  need to unseal Vault for this workshop. You can learn how to unseal Vault in
  the [CLI initialize and unseal documentation for
  Vault](https://www.vaultproject.io/docs/platform/k8s/helm/run#initialize-and-unseal-vault),
  and can try it on your own by reproducing this lab locally, following [this
  tutorial](https://learn.hashicorp.com/terraform/kubernetes/consul-vault-kubernetes-run-triggers).
