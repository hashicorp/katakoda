In this step, you will learn to use Terraform workspaces to manage two separate
environments with the same set of configuration.

**Note**: Before continuing with the next step, close the editor window for
`main.tf` to ensure the contents of the editor window don't overwrite this file
as you refactor your configuration.

## Consolidate configuration

Since the configuration found in `dev.tf` and `prod.tf` is almost identical, you
can consolidate it into one file managed by two workspaces.

Remove the `prod.tf` file you created in the last step.

```
rm prod.tf
```{{execute}}

Rename `dev.tf` back to `main.tf`.

```
mv dev.tf main.tf
```{{execute}}

The configuration still has references to the environment (dev or prod) in
several places. To make the configuration more generic, remove and replace these
references.

Replace the contents of `variables.tf`{{open}} with the following.

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

Also replace the contents of `outputs.tf`{{open}} with the following.

```
output "website_endpoint" {
  description = "Website endpoint for this environment"
  value       = "http://localhost:4572/${aws_s3_bucket.web.bucket}/index.html"
}
```{{copy}}

Now, update `main.tf`{{open}} to reflect the new variable name.

Update the bucket resource name from `dev` to `web`, and the bucket name
argument to use the new `var.prefix` variable.

```
- resource "aws_s3_bucket" "dev" {
-   bucket = ${var.dev_prefix}-${random_pet.petname.id}"
+   resource "aws_s3_bucket" "web" {
+   bucket = ${var.prefix}-${random_pet.petname.id}"
    acl    = "public-read"

    force_destroy = true

# ...
```

Also update the bucket resource name in the policy document to use the new
`var.prefix` variable.

```
"Resource": [
-  "arn:aws:s3:::${var.dev_prefix}-${random_pet.petname.id}/*"
+  "arn:aws:s3:::${var.prefix}-${random_pet.petname.id}/*"
]
```

And finally update the object resource name to `webapp`, and use the new name
for the bucket resource.

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

## Create variable definition files

Each workspace will use a different set of variable definitions.

Create a new file called `dev.tfvars`{{open}} to store variable definitions for
your development environment.

```
aws_region = "us-west-2"
prefix     = "dev"
```{{copy}}

Create another file called `prod.tfvars`{{open}}.

```
aws_region = "us-west-2"
prefix     = "prod"
```{{copy}}

## Create dev workspace

Now your configuration supports either a dev or prod environment.

Terraform commands operate in a default workspace, but you can create and manage
other workspaces as well. Create a new `dev` workspace.

```
terraform workspace new dev
```{{execute}}

Apply your configuration to the dev workspace.

```
terraform apply -var-file=dev.tfvars
```{{execute}}

Enter `yes`{{execute}} at the prompt, and open the website endpoint in your web
browser to verify that your infrastructure was deployed successfully.

## Create prod workspace

Now create and switch to a production workspace.

```
terraform workspace new prod
```{{execute}}

```
terraform apply -var-file=prod.tfvars
```{{execute}}

Again, respond to the prompt with `yes`{{execute}}, and check the new production
website endpoint.

Now your environments can be managed independently. This works well when the
configuration is identical between environments (aside from variable
definitions), but can be inflexible if you need different configuration between
environments, or need to manage the resources separately. You also need to
ensure that all commands are run in the correct workspace.

## Destroy resources

Before moving on, destroy the resources you've created so far.

```
terraform destroy -var-file=prod.tfvars
```{{execute}}

Be sure to answer `yes`{{execute}} at the prompt.

Switch to the development workspace.

```
terraform workspace select dev
```{{execute}}

Now destroy the development workspace. 

```
terraform destroy -var-file=dev.tfvars
```{{execute}}

And once again respond to the prompt with `yes`{{execute}}.

In the next step, you will learn to manage your configuration in separate directories.
