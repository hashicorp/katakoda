In the last step, you separated your configuration into two different files.
While this can help you organize configuration within a single project, it
doesn't help prevent accidental changes to parts of your infrastructure.

In this step, you will learn to use Terraform workspaces to manage two separate
environments with the same set of configuration.

**Note**: Before continuing with the next step, you will need to close the
editor window for `main.tf` to ensure the contents of the editor window don't
overwrite this file as you refactor your configuration.

## Consolidate Configuration

Since the configuration is almost identical in `dev.tf` and `prod.tf`, it can be
consolidated into one file managed by two workspaces.

Remove the `prod.tf` file you created in the last step, and rename `dev.tf` back
to `main.tf`:

```
rm prod.tf
mv dev.tf main.tf
```{{execute}}

The original configuration included references to the environment (dev or prod)
in several places. To make the configuration more generic, you will need to
remove and replace these references.

Replace the contents of `variables.tf`{{open}} with:

```
variable "aws_region" {
  description = "AWS region for all resources"
  default     = "us-west-2"
}

variable "prefix" {
  description = "Prefix for buckets in this environment."
  default     = "dev"
}
```{{copy}}

Also replace `outputs.tf`{{open}} with:

```
output "website_endpoint" {
  description = "Website endpoint for this environment"
  value       = "http://${aws_s3_bucket.web.website_endpoint}/index.html"
}
```{{copy}}

Now, update `main.tf`{{open}} to reflect these changes.

First, update the bucket resource name from `dev` to `web`, and bucket name
argument to use the new `var.prefix` variable:

```
- resource "aws_s3_bucket" "dev" {
+ resource "aws_s3_bucket" "web" {
- bucket = "${var.dev_prefix}-${random_pet.petname.id}"
+ bucket = "${var.prefix}-${random_pet.petname.id}"
```

Also update the bucket resource name in the policy document to use the new
`var.prefix` variable:

```
        "Resource": [
-           "arn:aws:s3:::${var.dev_prefix}-${random_pet.petname.id}/*"
+           "arn:aws:s3:::${var.prefix}-${random_pet.petname.id}/*"
        ]
```

And finally update the object resource name to `webapp`, and use the new name
for the bucket resource:

```
- resource "aws_s3_bucket_object" "dev" {
+ resource "aws_s3_bucket_object" "webapp" {

  acl          = "public-read"
  key          = "index.html"
- bucket       = aws_s3_bucket.dev.id
+ bucket       = aws_s3_bucket.web.id
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"
}
```

## Create Variable Definition Files

Each environment will use a different set of variable definitions.

Create a new file called `dev.tfvars`{{open}} to store variable definitions for your
development environment:

```
aws_region = "us-west-2"
prefix = "dev"
```{{copy}}

Create another file called `prod.tfvars`{{open}}:

```
aws_region = "us-west-2"
prefix = "prod"
```{{copy}}

## Apply Changes In Two Workspaces

Now your configuration supports either a dev or prod environment.

Terraform commands operate in a default workspace, but you can create and manage
other workspaces as well. Create a new `dev` workspace.

```
terraform workspace new dev
```{{execute}}

Apply your configuration to the dev workspace:

```
terraform apply -var-file=dev.tfvars
```{{execute}}

Enter `yes`{{execute}} at the prompt, and open the website endpoint in your web browser to
verify that your infrastructure was deployed successfully.

Now create and switch to a production workspace:

```
terraform workspace new prod
```{{execute}}

```
terraform apply -var-file=prod.tfvars
```{{execute}}

Again, respond to the prompt with `yes`{{execute}}, and check the new production website
endpoint.

Now your environments can be managed independently. This works well when the
configuration is identical between environments (aside from variable
definitions), but can be inflexible if you need different configuration between
environments, or need to manage the resources separately. You also need to
ensure that all commands are run in the correct workspace.

## Destroy Resources

Before moving on, destroy the resources you've created so far.

```
terraform destroy -var-file=prod.tfvars
```{{execute}}

Be sure to answer `yes`{{execute}} at the prompt.

```
terraform workspace select dev
terraform destroy -var-file=dev.tfvars
```{{execute}}

And once again respond to the prompt with `yes`{{execute}}.

In the next step, you will learn to manage your configuration in separate directories.

