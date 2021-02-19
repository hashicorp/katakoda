In this step, you will create two S3 buckets configured for static website
hosting using a monolithic configuration.

## Review AWS provider

Open `main.tf`{{open}}. Your configuration begins with the AWS provider block
below.

```
provider "aws" {
  region = "us-west-2"
  # ...
}
```

It also includes settings that allow this scenario to use
[localstack](https://localstack.cloud/) to simulate infrastructure, instead of
requiring an AWS account. Refer to the code in the [Learn
tutorial](https://learn.hashicorp.com/tutorials/terraform/module-use?in=terraform/modules)
to build real infrastructure, which will require you to authenticate with AWS. 

Refer to the [AWS Get Started
collection](https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started)
or the [AWS Provider Registry
page](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication)
to learn different ways to authenticate the AWS provider.

## Review monolithic configuration

Now that you have reviewed the AWS provider configuration, review the rest of the
configuration found in `main.tf`{{open}}. This configuration creates two S3
buckets, each configured to host a static website, and each containing a single
`index.html`. One bucket will be for your `dev` environment, and the other for
`prod`.

Notice the three variables used in your configuration. Open
`variables.tf`{{open}} and note how these variables are declared with default
values.

Now open `outputs.tf`{{open}}, which will defines outputs for the website
endpoints for the two buckets once Terraform creates them. Later you will use
these values to visit the website and verify that your configuration was
successfully deployed.

## Apply configuration

Initialize your Terraform workspace.

```
terraform init
```{{execute}}

Terraform will install two providers - one for AWS, and one for the `random_pet`
resource.

Now apply this configuration.

```
terraform apply
```{{execute}}

Respond with `yes`{{execute}} when prompted.

Verify the website endpoint URLs by copying them from the embedded terminal and pasting them into your web browser.

> **Note**: If your browser window is wide enough the link may only span one line, in which case it will be clickable from the embedded terminal. 

In the next step, you will begin to organize this configuration by separating
your development and production configuration.
