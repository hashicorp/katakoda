# Configure a Terraform Cloud token

There are three steps to running an existing Terraform configuration on Terraform Cloud. Two steps occur on the [Terraform Cloud](https://app.terraform.io) website:

- Create a free account including an organization and a workspace
- Use the `login` command to authenticate the local machine with Terraform Cloud
- Edit the existing Terraform configuration with the name of the Terraform Cloud organization and workspace

## Create an account

Sign up for a free account at [Terraform Cloud](https://app.terraform.io/signup/account).

You'll be asked to [create and name an organization](https://app.terraform.io/app/organizations/new). This could be the name of your company, your own name, the name of your department, or similar. For this example, we'll use `hashicorp-education` but you'll need to use your own unique organization name.

## Authenticate this machine to Terraform Cloud

To authenticate to Terraform Cloud, you must run the `login` command.

`terraform login`{{execute}}

You will be prompted to visit [Terraform Cloud](https://app.terraform.io/app/settings/tokens?source=terraform-login) and copy the generated token. Paste it into the terminal at the prompt.

Upon completion, a local file will be created with an authentication token.

## Edit the Terraform configuration

Now, edit `~/learn-state-migration/main.tf` with the name of the `organization` you created earlier. Under `workspaces`, use `state-migration` as the `name`. This workspace will be created on Terraform Cloud the first time you run `terraform init` in the next step.

`main.tf`{{open}}

```
terraform {
  backend "remote" {
    organization = "hashicorp-education"
    workspaces {
      name = "state-migration"
    }
  }
}
```

In the next step, you'll migrate your existing project to Terraform Cloud.
