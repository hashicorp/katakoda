Now that you have a monolithic configuration to work with, in this step you will
separate the configuration into two files, one for your "dev" environment, and
one for "prod".

## Separate Configuration Files

In this step, you will separate your production and development environments
into two configuration files.

First, copy `main.tf` to `dev.tf`.

```
cp main.tf dev.tf
```{{execute}}

Next, rename `main.tf` to `prod.tf`.

```
mv main.tf prod.tf
```{{execute}}

Your configuration only needs one instance of the provider and random_pet
blocks, so comment out or remove these lines from `prod.tf`{{open}}:

```
# provider "aws" {
#   access_key = "AKI#############IEU"
#   secret_key = "Kg7##################################yGv"
#   region     = "us-west-2"
# }

# resource "random_pet" "petname" {
#   length    = 4
#   separator = "-"
# }
```

Also remove the resource blocks for your dev environment from `prod.tf`{{open}}:

- Remove the entire `resource "aws_s3_bucket" "dev" { ... }` block
- Remove the entire `resource "aws_s3_bucket_object" "dev" { ... }` block

Once this is done, you will have two resource blocks in `prod.tf`: One for the
bucket, and one for the bucket object.

Now do the equivalent for `dev.tf`{{open}}:

- Remove the entire `resource "aws_s3_bucket" "prod" { ... }` block
- Remove the entire `resource "aws_s3_bucket_object" "prod" { ... }` block

Be sure to leave the aws provider and random_pet resource blocks in this file.
You will now have two resource blocks in `dev.tf`: One for the bucket, and one for
the bucket object.

## Apply Configuration

Since Terraform loads all `.tf` files in the current directory when it runs,
your configuration hasn't changed, so applying it will show no changes.

```
terraform apply
```{{execute}}

Ensure that you get no errors running this apply command before you continue.
You should see output like this:

```
# Output truncated...

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

dev_website_endpoint = http://hc-digital-dev-infinitely-vertically-busy-tapir.s3-website-us-west-2.amazonaws.com/index.html
prod_website_endpoint = http://hc-digital-prod-infinitely-vertically-busy-tapir.s3-website-us-west-2.amazonaws.com/index.html
```

Now your production and development environemnts are in separate files, but they
are managed by the same Terraform workspace, and share both configuration and
state. Because of this, a change that you intend to make in one environment can
affect the other.

## Make a Configuration Change

Update the random_pet resource in `dev.tf`{{open}}, changing value of the `length`
argument to "5".

```
resource "random_pet" "petname" {
  length    = 5
  separator = "-"
}
```{{copy}}

Now, apply these changes, and notice that all five of your resources will be
destroyed and recreated.

```
terraform apply
```{{execute}}

Respond with `yes`{{execute}} to apply the changes.

## Destroy Resources

Before moving on, destroy the resources you've created so far.

```
terraform destroy
```{{execute}}

Respond with `yes`{{execute}} when prompted.

In the next step, you will separate your dev and production environments into
different workspaces, so each can be managed separately.
