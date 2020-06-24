## Verify deployments

Now that you have deployed a Vault instance using Consul as a backend on a GKE cluster, you will connect to your Kubernetes cluster using `kubectl` to access the respective instances.

You will do this in KataCoda, using the editor and terminal you see on the right.

## Login with the Terraform CLI

First, login to Terraform Cloud using the CLI.

`terraform login`{{execute}} 

The command output will ask you if you want to confirm that you want to generate a token and store it. Confirm when it prompts you.

`yes`{{execute}} 

Terraform will prompt you to visit a link in the output.

Copy and paste the link in the output to generate a new token in Terraform Cloud. 

Copy the API token from Terraform Cloud and then paste it into the Katacoda terminal and press enter to confirm. The terminal will not display the token, so only paste your token once.

## Configure kubectl

Add the following configuration to your KataCoda `main.tf` file, replacing the `workspaces` value in [`main.tf`](https://github.com/hashicorp/learn-terraform-pipelines-k8s/blob/master/main.tf). 

- `workspaces   = "{firstName}-{lastInitial}-k8s"`

This will establish a connection to your Kubernetes workspace. 

<pre class="file" data-filename="main.tf" data-target="replace">
terraform {
  backend "remote" {
    organization = "infrastructure-pipelines-workshop"

    workspaces {
      name = "learn-terraform-pipelines-k8s"
    }
  }
}
</pre>

Then, initialize your Terraform workspace.

`terraform init`{{execute T1}} 

Save your Kubernetes workspace's `kubeconfig` output value into a file named `kubeconfig`. This will allow you to connect to your cluster.

`terraform output kubeconfig > kubeconfig`{{execute T1}} 

Check the number of nodes in your Kubernetes deployment.

`kubectl --kubeconfig=kubeconfig get nodes`{{execute T1}} 

Since Vault and Consul are enabled, you should see 5 nodes.

Check the Kubernetes cluster pods. You should see pods for both Consul and Vault.

`kubectl --kubeconfig=kubeconfig -n hashicorp-learn get pods`{{execute T1}} 

## Access Consul UI

Forward port :8500 (Consul UI) to port :8500, allowing you to access it on KataCoda's port 8500.

`kubectl --kubeconfig=kubeconfig -n hashicorp-learn port-forward --address 0.0.0.0 consul-server-0 8500:8500`{{execute T1}} 

Click on the "Consul UI" tab in your terminal pane or visit `[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com` in your browser to access the Consul UI.

> **Note:** The Consul UI does not show Vault in the list of services because its service_registration stanza in the Helm chart defaults to Kubernetes. However, Vault is still configured to use Consul as a backend.

## Access Vault UI

Open a new tab in the Katacoda terminal pane and forward port :8200 (Vault UI) to port :8200, allowing you to access it on KataCoda's port 8200.

`kubectl --kubeconfig=kubeconfig -n hashicorp-learn port-forward --address 0.0.0.0 hashicorp-learn-vault-0 8200:8200`{{execute T2}}

Go to the Vault UI tab in the Katacoda terminal pane or visit `[[HOST_SUBDOMAIN]]-8200-[[KATACODA_HOST]].environments.katacoda.com` in your browser to access the Vault UI.

> **Note:** The Vault pods have warnings because Vault is sealed. Do **not** unseal Vault during this workshop. You can learn how to unseal Vault in the [CLI initialize and unseal documentation for Vault](https://www.vaultproject.io/docs/platform/k8s/helm/run#initialize-and-unseal-vault), and can try it on your own by reproducing this lab locally, following [this tutorial](https://learn.hashicorp.com/terraform/kubernetes/consul-vault-kubernetes-run-triggers).

## Next steps

Congratulations — you have successfully completed the scenario and applied some Terraform Cloud best practices. By keeping your infrastructure configuration modular and integrating workspaces together using run triggers, your Terraform configuration becomes extensible and easier to understand.