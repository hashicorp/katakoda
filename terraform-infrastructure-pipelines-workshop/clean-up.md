## Clean up resources

To clean up the resources and destroy the infrastructure you have provisioned in this track, go to each workspace in the reverse order you created them in, queue a destroy plan, and apply it. Then, delete the workspace from Terraform Cloud. Destroy and delete your workspaces in the following order:

1. Vault workspace
2. Consul workspace
3. Kubernetes workspace

## Summary

Congratulations — you have successfully completed the scenario and applied some Terraform Cloud best practices. By keeping your infrastructure configuration modular and integrating workspaces together using run triggers, your Terraform configuration becomes extensible and easier to understand.
