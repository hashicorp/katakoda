# Migrate State to Terraform Cloud

Finally, migrate the project to Terraform Cloud and execute the configuration remotely. The steps include:

- Initialize your local configuration
- Delete your local `terraform.tfstate` file
- Apply your configuration remotely
- Update variables and run `apply` again
- Logout

## Initialize your local configuration`

First, run `init` to migrate the existing state to Terraform Cloud.

`terraform init`{{execute}}

You will be prompted to move state to Terraform Cloud.

## Delete local state

You may need to delete the local `terraform.tfstate` file to avoid warnings. State is now stored on Terraform Cloud so this file is no longer needed.

`rm terraform.tfstate`{{execute}}

## Run apply

Then, run `apply` to run the configuration in Terraform Cloud. This will also automatically create the `random-pet-demo` workspace on Terraform Cloud.

`terraform apply`{{execute}}

Because the existing state was copied to Terraform Cloud, and because no changes were made to the Terraform configuration code, no changes need to be provisioned at this time.

## Update variables and apply

To see the effect of a remotely executed command, make a change to `main.tf`. Change the `name_length` variable default value to `2` instead of `3`. This will trigger the creation of a new random pet name.

```diff
variable "name_length" {
  description = "The number of words in the pet name"
- default     = "3"
+ default     = "2"
}
```

Then, run `apply`:

`terraform apply`{{execute}}

As with a local Terraform run, you'll be asked to confirm. But this time, you'll be running the command in Terraform Cloud. The new random pet name is displayed as an output.

You can scroll up to find the URL to this run within your organization and workspace in Terraform Cloud.

Or, visit [Terraform Cloud](https://app.terraform.io/app) and select your organization. You'll see a workspace named `state-migration`. Click the workspace to see that it has been run. You can examine the output from the run or view state, variables, or other settings.

## Destroy and Logout

To complete this tutorial, destroy the state stored on Terraform cloud. This will not delete the organization or workspace, but will reset the workspace state so it can be used again in the future.

`terraform destroy`{{execute}}

To clear your authentication token from the local workstation, run `logout`.

`terraform logout`{{execute}}
