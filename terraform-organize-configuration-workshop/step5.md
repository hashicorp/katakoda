In this step, you will refactor the configuration from the last step to use a
module to define buckets used to host static websites.

Ensure that you are still working in the `learn-terraform` directory before moving on.

```
cd ~/learn-terraform
```{{execute}}

## Create Module Template

Now create a directory with empty files to define your module.

```
mkdir -p modules/terraform-aws-s3-static-website-bucket
cd modules/terraform-aws-s3-static-website-bucket
touch {README.md,main.tf,variables.tf,outputs.tf}
cd -
```{{execute}}

The file `README.md` isn't used by Terraform, but can be used to document your
module if you host it in a public or private Terraform Registry, or in a version
control system such as GitHub.

Add the following to `modules/terraform-aws-s3-static-website-bucket/README.md`{{open}}:

```
# AWS S3 static website bucket

This module provisions AWS S3 buckets configured for static website hosting.
```{{copy}}

## Create Module Configuration

Add the following configuration to `modules/terraform-aws-s3-static-website-bucket/main.tf`{{open}}:

```
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  acl    = "public-read"

  force_destroy = true

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
                "arn:aws:s3:::${var.bucket_name}/*"
            ]
        }
    ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}
```{{copy}}

Notice that you did not configure a provider for this module. Modules inherit
the provider configuration from the Terraform configuration that uses them.

Like any Terraform configuration, modules can have variables and outputs.

Add the following to `modules/terraform-aws-s3-static-website-bucket/variables.tf`{{open}}:

```
variable "bucket_name" {
  description = "Name of the s3 bucket. Must be unique."
  type        = string
}
```{{copy}}

And add the following to `modules/terraform-aws-s3-static-website-bucket/outputs.tf`{{open}}:

```
output "arn" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.s3_bucket.arn
}

output "name" {
  description = "Name (id) of the bucket"
  value       = aws_s3_bucket.s3_bucket.id
}

output "website_endpoint" {
  description = "Domain name of the bucket"
  value       = aws_s3_bucket.s3_bucket.website_endpoint
}
```{{copy}}

## Refactor Dev Configuration

Now refactor your `dev` configuration to use this module.

Open `dev/main.tf`{{open}} and remove the entire bucket resource block.

```
resource "aws_s3_bucket" "web" {
  bucket = "${var.prefix}-${random_pet.petname.id}"
  acl    = "public-read"

# ...

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}
```

Replace it with the following.

```
module "website_s3_bucket" {
  source = "../modules/terraform-aws-s3-static-website-bucket"

  bucket_name = "${var.prefix}-${random_pet.petname.id}"
}
```{{copy}}

And replace the bucket object resource block in the same file with the following
to reference the bucket created by the module.

```
resource "aws_s3_bucket_object" "webapp" {
  acl          = "public-read"
  key          = "index.html"
  bucket       = module.website_s3_bucket.name
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"
}
```{{copy}}

You will also need to update `dev/outputs.tf`{{open}} to refer to the module instead of
the resource name:

```
output "website_endpoint" {
  description = "Website endpoint for this environment"
  value       = "http://${module.website_s3_bucket.website_endpoint}/index.html"
}
```{{copy}}

## Initialize and Apply

Change into the dev directory and re-initialize it.

```
cd dev/
terraform init
```{{execute}}

**Note**: Whenever you add or update a module, you will need to re-run
`terraform init` or `terraform get` to install it, even if it is located on the
same filesystem as your Terraform configuration.

Now you can provision the bucket:

```
terraform apply
```{{execute}}

Respond `yes`{{execute}} to the prompt, and once again visit the website
endpoint in your web browser to verify the website was deployed correctly.

## Practice: Refactor Prod Configuration

Now refactor your `prod` configuration to use this module.

The steps to update and apply your production configuration are nearly identical
to the ones for your dev environment. Be sure to apply your configuration with
the `-var-file=prod.tfvars` flag.

## Destroy Resources

Clean up both environments by running `terraform destroy`{{execute}} in both directories.
Don't forget to include the `-var-file` argument!
