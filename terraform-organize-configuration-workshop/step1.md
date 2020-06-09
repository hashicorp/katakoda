In this step, you will create a monolithic configuration to use with the rest of
the scenario.

## Configure AWS Provider

First, configure an AWS provider.

Open `main.tf`{{open}}. Begin your configuration with the AWS provider block below.

```
provider "aws" {
  access_key = "REPLACE"
  secret_key = "REPLACE"
  region     = var.aws_region
}
```{{copy}}

You will need to replace the values for the access_key and secret_key arguments
with the ones provided to you for this session.

**Warning**: Hard-coding credentials into your Terraform configuration is not
recommended outside of this lab environment.

## Create Monolithic Configuration

Now that your AWS provider is configured, copy and paste the following example configuration
into `main.tf`.

```
resource "random_pet" "petname" {
  length    = 4
  separator = "-"
}

resource "aws_s3_bucket" "dev" {
  bucket = "hc-digital-${var.dev_prefix}-${random_pet.petname.id}"
  acl    = "public-read"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::hc-digital-${var.dev_prefix}-${random_pet.petname.id}/*"
            ]
        }
    ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"

  }
  force_destroy = true
}

resource "aws_s3_bucket_object" "dev" {
  acl          = "public-read"
  key          = "index.html"
  bucket       = aws_s3_bucket.dev.id
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"

}

resource "aws_s3_bucket" "prod" {
  bucket = "hc-digital-${var.prod_prefix}-${random_pet.petname.id}"

  acl    = "public-read"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::hc-digital-${var.prod_prefix}-${random_pet.petname.id}/*"
            ]
        }
    ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"

  }
  force_destroy = true
}

resource "aws_s3_bucket_object" "prod" {
  acl          = "public-read"
  key          = "index.html"
  bucket       = aws_s3_bucket.prod.id
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"
}
```{{copy}}

This configuration includes two s3 buckets set up for static website hosting:
`dev`, and `prod`.

You may have noticed three variables being used in the above configuration. Define
these variabled by adding the following to `variables.tf`{{open}}.

```
variable "aws_region" {
  description = "AWS region for all resources"
  default     = "us-west-2"
}

variable "dev_prefix" {
  description = "Prefix for buckets in the dev environment"
  default     = "dev"
}

variable "prod_prefix" {
  description = "Prefix for buckets in the prod environment"
  default     = "prod"
}
```{{copy}}

You will also want to know the website endpoints for these two buckets. Add the
following to `outputs.tf`{{open}}:

```
output "dev_website_endpoint" {
  description = "Website endpoint for the dev environment"
  value       = "http://${aws_s3_bucket.dev.website_endpoint}/index.html"
}

output "prod_website_endpoint" {
  description = "Website endpoint for the prod environment"
  value       = "http://${aws_s3_bucket.prod.website_endpoint}/index.html"
}
```{{copy}}

These three files make up the configuration for the environment you will work
with for this session.

## Apply Configuration

Initialize your Terraform workspace:

```
terraform init
```{{execute}}

Terraform with install two providers.

Now apply this configuration:

```
terraform apply
```{{execute}}

Respond with `yes`{{execute}} when prompted.

You can verify the website endpoint URLs by opening them in your web browser.

In the next step, you will begin to organize this configuration by seperating
your development and production configuration.
