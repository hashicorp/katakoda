In this step, you will create two S3 buckets configured for static website
hosting using a monolithic configuration.

## Configure AWS Provider

Open `main.tf`{{open}}. Your configuration begins with the AWS provider block
below.

```
provider "aws" {
  region = var.aws_region
}
```{{copy}}

Terraform will use IAM credentials to authenticate with your AWS account. To do
so, you will need to export two environment variables in the terminal window.

```
$ export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
$ export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

You will need to replace the values for the access key ID and secret access key
values with credentials configured with the correct IAM policy.

You can review `assets/policy.json`{{open}} for an example of an appropriate IAM policy
for the actions you will take while following this scenario.

## Review Monolithic Configuration

Now that you have configured the AWS provider, review the rest of the
configuration found in `main.tf`{{open}}. This configuration will create two s3
buckets, each configured to host a static website, and each containing a single
"index.html". One bucket will be for your "dev" environment, and the other for
"prod".

You may have noticed three variables being used in your configuration. These
variables are defined in `variables.tf`{{open}}.

The file `outputs.tf`{{open}} will output the website endpoints for these two
buckets. You can use these values to visit the website and verify that your
configuration was successfully deployed.

## Apply Configuration

Initialize your Terraform workspace.

```
terraform init
```{{execute}}

Terraform with install two providers - one for AWS, and one for the "random_pet"
resource.

Now apply this configuration.

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
