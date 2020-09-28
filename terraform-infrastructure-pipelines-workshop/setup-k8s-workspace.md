## Setup Terraform Cloud workspaces

In the next few steps, you will locate your pre-configured workspaces
(Kubernetes, Consul, and Vault) in Terraform Cloud. Then you will connect them
to a version control system (VCS), verify the variables are set up properly, and
set up run triggers connecting the workspaces.

Check the email address you used to sign up for the workshop. You should find an
invitation to join the `infrastructure-pipelines-workshop` organization in
Terraform Cloud. Accept this invitation and login to [Terraform
Cloud](https://app.terraform.io/app/infrastructure-pipelines-workshop). Within
the workshop organization, you will find 3 workspaces starting with your first
name and middle initial. For example, if your name is John Doe, you should see:

- `john-d-k8s`
- `john-d-consul`
- `john-d-vault`

You will use these three workspaces for the rest of this workshop.

## Configure the Kubernetes workspace

You will need to create your own forks of the repositories used in this
workshop, and configure them to use your Terraform Cloud workspaces. Start with
the Kubernetes ("john-d-k8s") workspace.

1. Fork the [Learn Terraform Pipelines K8s
   repository](https://github.com/hashicorp/learn-terraform-pipelines-k8s) into
   your own GitHub account using the `fork` interface in GitHub.
1. In your forked repository, navigate to `main.tf`.
1. Use the "pencil"/edit button to edit the file.
1. Replace the `organization` and `workspaces` values with the organization set
   up for this workshop ("infrastructure-pipelines-workshop"), and your unique
   workspace name ("{firstName}-{lastInitial}-k8s").<br/>
1. Commit your changes directly to the "master" branch of your forked
  repository.

The `main.tf` file should look similar to the following.

```
terraform {
  backend "remote" {
    organization = "infrastructure-pipelines-workshop"

    workspaces {
      name = "john-d-k8s"
    }
  }
}
```

Now that your GitHub repository is configured for use with the Terraform Cloud
workspace, connect them in the Terraform Cloud UI.

### Connect workspace to forked repository

Visit the [Terraform Cloud
UI](https://app.terraform.io/app/infrastructure-pipelines-workshop).

1. Select your Kubernetes workspace ("john-d-k8s").
1. Within the workspace UI, click on "Settings" and then "Version Control".
  ![Click on "Settings" then "Version Control" to access workspace version control](./assets/configure-vcs.png)
1. Click on "Connect to version control" and choose "Version control
   workflow".
1. Select "Github".
  - If this is your first time using Terraform Cloud with GitHub, it will ask
    you to authorize Terraform Cloud to access GitHub.
1. Select your **forked** Kubernetes repo:
  `{your-github-username}/learn-terraform-pipelines-k8s`
1. Click "Update VCS settings" to connect this workspace to your forked GitHub
   repository.

### Verify variables

Next, click on "Variables" in the workspace UI. Both the Terraform Variables and
Environment Variables will already be set for you.

Verify that these variables are set correctly before moving on.

#### Terraform Variables

These correspond to the variables declared in
[`variables.tf`](https://github.com/hashicorp/learn-terraform-pipelines-k8s/blob/master/variables.tf).

- **region** — GCP region to deploy clusters<br/>
  This will be set to `europe-west4`. For a full list of GCP regions, refer to [Google’s Region and Zones documentation](https://cloud.google.com/compute/docs/regions-zones).
- **password** — Password for Kubernetes cluster<br/>
  This can be anything over 16 characters, but for this workshop it defaults to
  `infrastructurepipelines`, and will be marked **sensitive**.
  Terraform will set this when it creates your Kubernetes cluster and will
  distribute it as necessary when creating your Consul and Vault clusters. You
  will not need to manually input this value.
- **enable_consul_and_vault** — Enable Consul and Vault for the secrets cluster<br/>
  This will be set to `false`. This variable dictates whether Consul and Vault
  should be deployed on your Kubernetes cluster.
- **username** — Username for Kubernetes cluster<br/>
  This can be anything, but defaults to `hashicorp`.
- **google_project** — Google Project to deploy cluster<br/>
  This is the Google Cloud project for your infrastructure, and will be set to
  something similar to `{firstName}-{lastInitial}-{randomString}`.
- **cluster_name** — Name of Kubernetes cluster<br/>
  This will be set to `tfc-pipelines`.

#### Environment Variables

The Terraform Google Cloud provider will use these credentials to authenticate
with the Google Cloud API.

- **GOOGLE_CREDENTIALS** — Flattened JSON of your GCP credentials.<br/>
  This will already been set for you and marked **sensitive**. These credentials
  have access to both the **Compute Admin** and **GKE Admin** roles.

## Deploy the Kubernetes cluster

Use the `Queue Plan` interface to queue a plan for your workspace.

If the plan is successful, Terraform Cloud will ask you to confirm and apply.

Click "Confirm & Apply" to apply this configuration. This process should take
about 10 minutes to complete. 

While your Kubernetes cluster is being deployed, continue on to the next step
and configure your Consul workspace.

## Next steps

You have successfully configured your Kubernetes workspace. Terraform Cloud will
use the configuration provided in your GitHub repository to deploy your
Kubernetes cluster. The Kubernetes workspace will output the Kubernetes
credentials for the Helm charts to consume in the Consul and Vault workspaces.
These values are specified in the Kubernetes GitHub repository in
[`outputs.tf`](https://github.com/hashicorp/learn-terraform-pipelines-k8s/blob/master/outputs.tf).

In the next step, you will configure your Consul workspace in a similar fashion.
