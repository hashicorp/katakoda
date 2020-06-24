## Setup Terraform Cloud workspaces

In this step, you will locate your pre-configured workspaces (Kubernetes, Consul, Vault) in Terraform Cloud. Then, you will connect them to a version control system (VCS), verify the variables are set up properly, then set up run triggers connecting the workspaces.

Create the following 3 workspaces in your Terraform Cloud organization.

- `learn-terraform-pipelines-k8s`
- `learn-terraform-pipelines-consul`
- `learn-terraform-pipelines-vault`

These will be your workspaces for the duration of this guide.

## Configure Kubernetes workspace

Fork the [Learn Terraform Pipelines K8s repository](https://github.com/hashicorp/learn-terraform-pipelines-k8s). Update the `organization` and `workspaces` values in [`main.tf`](https://github.com/hashicorp/learn-terraform-pipelines-k8s/blob/master/main.tf) to point to your organization and your workspace name.

```hcl
terraform {
  backend "remote" {
    organization = "hashicorp-learn"

    workspaces {
      name = "learn-terraform-pipelines-k8s"
    }
  }
}
```
### Connect workspace to forked repository

Click on your Kubernetes workspace (`learn-terraform-pipelines-k8s`). Click on "Settings" then "Version Control" to access workspace's version control.

![Click on "Settings" then "Version Control" to access workspace version control](./assets/configure-vcs.png)

Then, click on "Connect to version control". Select "Github" — it will ask you to authorize GitHub if this is your first time using Terraform Cloud. Select your **forked** Kubernetes repo: `learn-terraform-pipelines-k8s`. Finally, click "Update VCS settings". This will connect this workspace to your forked Kubernetes repo.

### Verify variables

Next, click on "Variables". Set the variables declared in [`variables.tf`](https://github.com/hashicorp/learn-terraform-pipelines-k8s/blob/master/variables.tf) in Terraform Variables.

#### Terraform Variables
- **region** — GCP region to deploy clusters<br/>
  Set this to a valid GCP region like `us-central1`.  For a full list of GCP regions, refer to [Google’s Region and Zones documentation](https://cloud.google.com/compute/docs/regions-zones).
- **cluster_name** — Name of Kubernetes cluster<br/>
  Set this to `tfc-pipelines`.
- **google_project** — Google Project to deploy cluster<br/>
  This must already exist. Find it in your Google Cloud Platform console.
- **username** — Username for Kubernetes cluster<br/>
  This can be anything; Terraform will set your username to this value when it creates the Kubernetes cluster.
- **password** — Password for Kubernetes cluster<br/>
  Mark as **sensitive**. This can be anything over 16 characters. Terraform will set this when it creates your Kubernetes cluster and will distribute it as necessary when creating your Consul and Vault clusters. You do not need to manually input this value again.
- **enable_consul_and_vault** — Enable Consul and Vault for the secrets cluster<br/>
  This should be set to `false`. This variable dictates whether Consul and Vault should be deployed on your Kubernetes cluster.

Then, set your `GOOGLE_CREDENTIALS` as a **sensitive environment variable**.

#### Environment Variables
- **GOOGLE_CREDENTIALS** — Flattened JSON of your GCP credentials.<br/>
  Mark as **sensitive**. This key must have access to both **Compute Admin** and **GKE Admin**.

You must flatten the JSON (remove newlines) before pasting it into Terraform Cloud. The command below flattens the JSON using [jq](https://stedolan.github.io/jq/).

```shell
cat <key file>.json | jq -c
```

## Deploy Kubernetes cluster

Queue a plan by clicking on "Queue Plan". If the plan is successful, Terraform Cloud will ask you to confirm and apply.

Click "Confirm & Apply" to apply this configuration. This process should take about 10 minutes to complete. 

While your Kubernetes cluster deploying, continue onto the next step and configure your Consul workspace.

## Next steps

You have successfully configured your Kubernetes workspace. Terraform Cloud will use these values to deploy your Kubernetes cluster. The pipeline will output the Kubernetes credentials for the Helm charts to consume in the Consul and Vault workspaces. These values are specified in [`output.tf`](https://github.com/hashicorp/learn-terraform-pipelines-k8s/blob/master/outputs.tf).

In the next step, you will configure your Consul workspace.

