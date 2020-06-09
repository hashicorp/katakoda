## Configure Consul workspace

Fork the [Learn Terraform Pipelines Consul repository](https://github.com/hashicorp/learn-terraform-pipelines-consul). Replace the `organization` and `workspaces` values in [`main.tf`](https://github.com/hashicorp/learn-terraform-pipelines-consul/blob/master/main.tf). 
- `organization = "infrastructure-pipelines-workshop"`
- `workspaces   = "{firstName}-{lastInitial}-consul"`

```hcl
terraform {
  backend "remote" {
    organization = "infrastructure-pipelines-workshop"

    workspaces {
      name = "john-d-consul"
    }
  }
}
```
### Connect workspace to forked repository

Click on your Consul workspace (`john-d-consul`). Click on "Settings" then "Version Control" to access workspace's version control.

Click on "Connect to version control". Select "Github" then your **forked** Consul repo: `learn-terraform-pipelines-consul`. Finally, click "Update VCS settings". This will connect this workspace to your forked Consul repo.

Select "Include submodules on clone" then click on "Update VCS settings". This will clone any submodules in your Consul repo. 

![Click on "Include submodules on clone" then click on "Update VCS settings"](./assets/include-submodules.png)

### Verify variables

Next, click on "Variables". Your Terraform Variables should already be set for you. These correspond with the variables in [`variables.tf`](https://github.com/hashicorp/learn-terraform-pipelines-consul/blob/master/variables.tf). Verify your variables have been set correctly.

#### Terraform Variables
- **namespace** — Kubernetes Namespace to deploy the Consul Helm chart<br/>
  This should be set to `hashicorp-learn`. You will use this to access your Consul and Vault instances later.
- **organization** - Organization of workspace that created the Kubernetes cluster<br/>
  This should be set to `infrastructure-pipelines-workshop`.
- **release_name** — Helm Release name for Consul chart<br/>
  This should be set to `hashicorp-learn`. Your Vault pods will start with this release name.
- **cluster_workspace** — Workspace that created the Kubernetes cluster<br/>
  This should be set to `{firstName}-{lastInitial}-k8s` (`john-d-k8s`).

### Enable run triggers 

Click on "Settings" then select "Run Triggers".

Under "Source Workspaces", select your Kubernetes workspace(`john-d-k8s`) then click "Add Workspace".

![Select Kubernetes workspace as source workspace](./assets/enable-run-triggers.png)

## Next steps

You have successfully configured your Consul workspace. The pipeline will retrieve the Kubernetes credentials from the Kubernetes workspace to authenticate to the Kubernetes and Helm provider.

In the next step, you will configure your Consul workspace.
