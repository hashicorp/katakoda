This is the environment for the Terraform **Infrastructure Pipelines Workshop**
and contains the latest version of the Terraform CLI and kubectl.

This workshop is comprised of six main steps, estimated to take a total of 45
minutes.

1. Setup Kubernetes workspace
2. Setup Consul workspace
3. Setup Vault workspace
4. Deploy Kubernetes, Consul and Vault
5. Verify deployments
6. Clean up resources

By the end of this scenario, you will accomplish three things using Terraform
Cloud run triggers.

- Deploy a Kubernetes cluster on Google Cloud.
- Deploy Consul on the Kubernetes cluster using a Helm chart
- Deploy Vault (configured to use a Consul backend) on the Kubernetes cluster using a Helm chart.

The Terraform configuration for each resource (Kubernetes, Consul, and Vault)
are modularized and committed to their respective version control system
repositories. Before the workshop, you received an email giving you access to
the Terraform Cloud workspaces for each resource. These workspaces are
pre-configured with some of the variables you will need to complete the
workshop.

You will complete the first few steps in Terraform Cloud and the GitHub UI. Once
those are complete, you will use the Katacoda environment provided here to
complete the final steps.
