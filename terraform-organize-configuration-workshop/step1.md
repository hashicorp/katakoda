In this step, you will create two S3 buckets configured for static website
hosting using a monolithic configuration.

## Configure AWS Provider

First, configure the AWS provider.

Open `main.tf`{{open}}. Your configuration begins with the AWS provider block below.

```
provider "aws" {
  region     = var.aws_region
}
```{{copy}}

Terraform will need to authenticate with your AWS account. To do so, you will
need to export two environment variables in the terminal window.

```
$ export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
$ export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

You will need to replace the values for the access key ID and secret access key values
with the ones provided to you for this session.

## Create Monolithic Configuration

Now that your AWS provider is configured, review the rest of the configuration
found in `main.tf`{{open}}. You will find 5 resource blocks.

The first resource block generates a random string that is used to give the S3 buckets your
configuration creates unique names.

Next, you will see a pair of blocks that configure an S3 bucket for static
website hosting, and an "index.html" object in the bucket. These represent your
"dev" environment.

The final two resource blocks are almost identical to the previous two, and
represent your "prod" environment.

You may have noticed three variables being used in your configuration. These
variables are defined in `variables.tf`{{open}}.

The file `outputs.tf`{{open}} will output the website endpoints for these two
buckets. You can use these values to visit the website and verify that your
configuration was successfully deployed.

These three files make up the configuration for the environment you will work
with for this session.

## Apply Configuration

Initialize your Terraform workspace:

```
terraform init
```{{execute}}

Terraform with install two providers - one for AWS, and one for the "random_pet"
resource.

Now apply this configuration:

```
terraform apply
```{{execute}}

Respond with `yes`{{execute}} when prompted.

You can verify the website endpoint URLs by opening them in your web browser.

**Note**: Depending on the width of your browser window, the URL shown may be
split across two lines. In that case, you'll need to select the entire URL and
copy and paste it into your browser window rather than clicking on it.

In the next step, you will begin to organize this configuration by separating
your development and production configuration.
