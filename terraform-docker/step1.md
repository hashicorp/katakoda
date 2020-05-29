A Terraform configuration is a series of code blocks that define your intended infrastructure. You'll run the `terraform` command against this file to create an Nginx webserver and view the default Nginx web page.

## View code

First, open the `main.tf` file in the text editor by clicking this link.

`main.tf`{{open}}

You don't have to edit or even understand the code. It defines two resources: a Docker disk image that packages the Nginx webserver, and a Docker container that gives it a name and runs it on port 80.

## Init

All Terraform workflows start with the `init` command. Terraform searches the configuration for both direct and indirect references to providers (such as Docker). Terraform then attempts to load the required plugins.

`terraform init`{{execute}}

## Apply

Now provision the webserver by running `apply`.

`terraform apply`{{execute}}

You will be asked to confirm. Type `yes` and press `ENTER`. It may take up to 30 seconds. A message will display confirmation that it succeeded.

## Verify

Visit this URL to view the default Nginx web page which is now live:

- [Nginx index page](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/)

Alternatively, you can examine Docker's process list. You will see the `tutorial` container which is running Nginx.

`docker ps`{{execute}}

## Destroy

To remove the Nginx webserver as defined in `main.tf`, run the destroy command.

`terraform destroy`{{execute}}

You will be prompted to confirm. Type `yes` and press `ENTER`.

## Conclusion

You have now created and destroyed your first Terraform resources! Terraform supports hundreds of ecosystem providers, from major cloud resources to content delivery networks and more.

Continue learning at [HashiCorp Learn](https://learn.hashicorp.com/terraform) and the [Terraform API documentation](https://www.terraform.io/) or discuss with others on the [Terraform forum](https://discuss.hashicorp.com/c/terraform-core/27).