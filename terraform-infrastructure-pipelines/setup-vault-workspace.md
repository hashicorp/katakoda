## Configure Vault workspace

Fork the [Learn Terraform Pipelines Vault repository](https://github.com/hashicorp/learn-terraform-pipelines-vault). Update the `organization` and `workspaces` values in [`main.tf`](https://github.com/hashicorp/learn-terraform-pipelines-k8s/blob/master/main.tf) to point to your organization and your workspace name.

```hcl
terraform {
  backend "remote" {
    organization = "hashicorp-learn"

    workspaces {
      name = "learn-terraform-pipelines-vault"
    }
  }
}
```

### Connect workspace to forked repository

Click on your Vault workspace (`learn-terraform-pipelines-vault`). Click on "Settings" then "Version Control" to access workspace's version control.

Click on "Connect to version control". Select "Github" then your **forked** Vault repo: `learn-terraform-pipelines-vault`. Finally, click "Update VCS settings". This will connect this workspace to your forked Vault repo.

Select "Include submodules on clone" then click on "Update VCS settings". This will clone any submodules in your Consul repo. 

### Verify variables

Next, click on "Variables". Your Terraform Variables should already be set for you. These correspond with the variables in [`variables.tf`](https://github.com/hashicorp/learn-terraform-pipelines-consul/blob/master/variables.tf). Verify your variables have been set correctly.

#### Terraform Variables
- **consul_workspace** —Terraform Cloud Workspace for the Consul cluster. 
  If you didn't customize your workspace name, this is `learn-terraform-pipelines-consul`.
- **cluster_workspace** — Terraform Cloud Workspace for the Kubernetes cluster.
  If you didn't customize your workspace name, this is `learn-terraform-pipelines-k8s`.
- **organization** — Organization of workspace that created the Kubernetes cluster.
  Set this to your Terraform Cloud Organization.

### Enable run triggers 

Click on "Settings" then select "Run Triggers".

Under "Source Workspaces", select your Consul workspace(`learn-terraform-pipelines-consul`) then click "Add Workspace".

## Next Steps

You have successfully configured your Vault workspace. The pipeline will retrieve the Kubernetes credentials from the Kubernetes workspace to authenticate to the Helm provider; the pipeline will retrieve the Helm release name and Kubernetes namespace from the Consul workspace.

In the next step, you will deploy a Consul instance and Vault instance onto your Kubernetes cluster.
