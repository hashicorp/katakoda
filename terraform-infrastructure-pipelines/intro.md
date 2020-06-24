This is the workspace for the Terraform [**Deploy Consul and Vault on Kubernetes with Run Triggers** Learn guide](https://learn.hashicorp.com/terraform/kubernetes/consul-vault-kubernetes-run-triggers) and contains the latest version of Terraform CLI and kubectl.

The learn guide comprises of six main steps, estimated to take a total of 45 minutes. The first 4 steps will be done using Terraform Cloud and GitHub.

1. Setup Kubernetes workspace
2. Setup Consul workspace
3. Setup Vault workspace
4. Deploy Kubernetes, Consul and Vault
5. Verify deployments
6. Clean up resources

By the end of this scenario, you will accomplish three things using Terraform Cloud run triggers.

- Deploy a Kubernetes cluster on Google Cloud.
- Deploy Consul on the Kubernetes cluster using a Helm chart
- Deploy Vault (configured to use a Consul backend) on the Kubernetes cluster using a Helm chart.

The Terraform configuration for each resource (Kubernetes, Consul, and Vault) are modularized and committed to their respective version control system repositories. First, you will create and configure TFC workspaces for each resource, then link them together using run triggers.
