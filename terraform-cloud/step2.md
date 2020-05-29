# Configure a Terraform Cloud token

There are three steps to running an existing Terraform configuration on Terraform Cloud. Two steps occur on the [Terraform Cloud](https://app.terraform.io) website:

- Create a free account including an organization and a workspace
- Use the `login` command to authenticate the local machine with Terraform Cloud
- Edit the existing Terraform configuration with the name of the Terraform Cloud organization and workspace

## Create an account

Sign up for a free account at [Terraform Cloud](https://app.terraform.io/signup/account).

You'll be asked to [create an organization](https://app.terraform.io/app/organizations/new). This could be the name of your company, your own name, the name of your department, or similar. For this example, we'll use `hashicorp-education` but you'll need to use your own unique organization name.

## Authenticate this machine to Terraform Cloud

To authenticate to Terraform Cloud, you must run the `login` command. Your web browser will open Terraform Cloud. Upon completion, a local file will be created with an authentication token.

`terraform login`{{execute}}

## Edit the Terraform configuration

Finally, edit `~/random-pet-demo/main.tf` with the name of the `organization` you created earlier. Under `workspaces`, use `random-pet-demo` as the `name`. This workspace will be created on Terraform Cloud the first time we run `terraform init` in the next step.

```
terraform {
  backend "remote" {
    organization = "hashicorp-education"
    workspaces {
      name = "random-pet-demo"
    }
  }
}
```

In the next step, you'll migrate your existing project to Terraform Cloud.
