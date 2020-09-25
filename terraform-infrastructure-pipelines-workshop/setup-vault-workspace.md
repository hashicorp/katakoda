## Configure the Vault workspace

Once again, the steps to configure your Vault workspace will be similar to the
previous two workspaces.

1. Fork the [Learn Terraform Pipelines Vault
   repository](https://github.com/hashicorp/learn-terraform-pipelines-vault)
   into your own GitHub account using the `fork` interface in GitHub.
1. In your forked repository, navigate to `main.tf`.
1. Use the "pencil"/edit button to edit the file.
1. Replace the `organization` and `workspaces` values with the organization set
   up for this workshop ("infrastructure-pipelines-workshop"), and your unique
   workspace name ("{firstName}-{lastInitial}-vault").
1. Commit your changes directly to the "master" branch of your forked
  repository.

The `main.tf` file should look similar to the following.

```
terraform {
  backend "remote" {
    organization = "infrastructure-pipelines-workshop"

    workspaces {
      name = "john-d-vault"
    }
  }
}
```

Now that your GitHub repository is configured for use with the Terraform Cloud
workspace, connect them in the Terraform Cloud UI.

### Connect workspace to forked repository

Visit the [Terraform Cloud
UI](https://app.terraform.io/app/infrastructure-pipelines-workshop).

1. Select your Vault workspace ("john-d-vault").
1. Within the workspace UI, click on "Settings" and then "Version Control".
  ![Click on "Settings" then "Version Control" to access workspace version control](./assets/configure-vcs.png)
1. Click on "Connect to version control" and choose "Version control
   workflow".
1. Select "Github".
1. Select your **forked** Vault repo:
  `{your-github-username}/learn-terraform-pipelines-vault`
1. Click "Update VCS settings" to connect this workspace to your forked GitHub
   repository.
1. Just as you did for the Consult workspace, select "Include submodules on
   clone", and then click on "Update VCS settings". 

### Verify variables

Next, click on "Variables" in the Terraform Cloud workspace UI.

Your Terraform Variables will already be set for you. These correspond with the
variables in
[`variables.tf`](https://github.com/hashicorp/learn-terraform-pipelines-vault/blob/master/variables.tf).

Verify that these variables are set correctly before moving on.

#### Terraform Variables

- **organization** — Organization of workspace that created the Kubernetes cluster
  This will be set to `infrastructure-pipelines-workshop`.
- **consul_workspace** —Terraform Cloud Workspace for the Consul cluster. 
  This will be set to something similar to `{firstName}-{lastInitial}-consul` (`john-d-consul`).
- **cluster_workspace** — Terraform Cloud Workspace for the Kubernetes cluster.
  This will be set to something similar to `{firstName}-{lastInitial}-k8s` (`john-d-k8s`).

### Enable run trigger

In the Workspace UI, click on "Settings" and then select "Run Triggers".

Under "Source Workspaces", select your Consul workspace ("john-d-consul") then
click "Add Workspace".

## Next Steps

You have successfully configured your Vault workspace. The pipeline will
retrieve the Kubernetes credentials from the Kubernetes workspace to
authenticate to the Helm provider. The pipeline will also retrieve the Helm
release name and Kubernetes namespace from the Consul workspace.

In the next step, you will deploy a Consul instance and Vault instance onto your
Kubernetes cluster.
