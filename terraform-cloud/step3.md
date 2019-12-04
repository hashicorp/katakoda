# Migrate State to Terraform Cloud

Finally, run `init` and `apply` to migrate state to Terraform Cloud and execute it remotely.

First, run `init`:

`terraform init`{{execute}}

You will be prompted to move state to Terraform Cloud.

Then, run `apply` to run the configuration in Terraform Cloud. This will also automatically create the `random-pet-demo` workspace on Terraform Cloud.

`terraform apply`{{execute}}

As with a standard Terraform run, you'll be asked to confirm. But this time, you'll be running the command in Terraform Cloud.

Visit [Terraform Cloud](https://app.terraform.io/app) and select your organization. You'll see a workspace named `random-pet-demo`. Click the workspace to see that it has been run. You can examine the output from the run or view state, variables, or other settings.

To destroy the workspace, type:

`terraform destroy`{{execute}}