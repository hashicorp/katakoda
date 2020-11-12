Open the `terraform.tf`{{open}} configuration. This file should contain the default Terraform providers block of minimum versions of your Datadog, Helm, and Kubernetes providers as well as the minimum version of Terraform.

Open the `kubernetes.tf`{{open}} file. The Learn tutorial will walk you through each block.

Now that you have reviewed the infrastructure, initialize your configuration.

`terraform init`{{execute}}


Apply your configuration. Remember to confirm your apply with a `yes`.

`terraform apply`{{execute}}

Verify your namespace.

`kubectl get namespaces --namespace=beacon`{{execute}}

Verify your deployment.

`kubectl get deployment --namespace=beacon`{{execute}}

To view the service in action, click the "View Beacon" tab in the Katacoda scenario or go to [this link](https://[[HOST_SUBDOMAIN]]-30201-[[KATACODA_HOST]].environments.katacoda.com/) directly. This will launch another web browser serving the Nginx service.


