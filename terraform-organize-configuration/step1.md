In this step, you will create two S3 buckets configured for static website
hosting using a monolithic configuration.

## Review AWS Provider

Open `main.tf`{{open}}. Your configuration begins with the AWS provider block
below.

```
provider "aws" {
  region = var.aws_region
}
```

This Katacoda scenario uses [localstack](https://localstack.cloud/) to provide a 
testing environment with same functionality and APIs as the real AWS cloud 
environment. This way you can learn how to organize your Terraform configuration 
without needing an AWS account.

As a result, the AWS provider block will have additional boilerplate which isn't 
required for a standard Terraform AWS workflow.

Refer to the [AWS Get Started collection](https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started)
or the [AWS Provider Registry page](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication)
to learn different ways  to authenticate the AWS provider.

## Review Monolithic Configuration

Now that you have configured the AWS provider, review the rest of the
configuration found in `main.tf`{{open}}. This configuration will create two s3
buckets, each configured to host a static website, and each containing a single
`index.html`. One bucket will be for your `dev` environment, and the other for
`prod`.

Notice the three variables used in your configuration. Open `variables.tf`{{open}} and notice how these variables are declared with default values.

Now open `outputs.tf`{{open}}, which will output the website endpoints for the two
buckets once Terraform creates them. Later you will use these values to visit the website and verify that your
configuration was successfully deployed.

## Apply Configuration

Initialize your Terraform workspace.

```
terraform init
```{{execute}}

Terraform with install two providers - one for AWS, and one for the `random_pet`
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
