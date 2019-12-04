# Configure a Terraform Cloud token

There are three steps to running an existing Terraform configuration on Terraform Cloud. Two steps occur on the [Terraform Cloud](https://app.terraform.io) website:

- Create a free account including an organization and a workspace
- Generate an API token and copy it to a local file
- Edit the existing Terraform configuration with the name of the Terraform Cloud organization and workspace

## Create an account

Sign up for a free account at [Terraform Cloud](https://app.terraform.io/signup/account).

You'll be asked to [create an organization](https://app.terraform.io/app/organizations/new). This could be the name of your company, your own name, the name of your department, or similar. For this example, we'll use `hashicorp-education` but you'll need to use your own unique organization name.

## Generate a token

To authenticate to Terraform Cloud, you must create a `.terraformrc` file with a unique token.

Go to the [Tokens](https://app.terraform.io/app/settings/tokens) page under your user icon, the "User Settings" menu, and the "Tokens" submenu. Create a token named `random-pet-demo`.

Copy the token displayed on the screen.

We've created a scaffold for you at `~/.terraformrc`. Open it in the editor and paste your token inside the double quotes on the `token` line: `token = ""`.

```
credentials "app.terraform.io" {
  token = "aaaa"
}
```

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
