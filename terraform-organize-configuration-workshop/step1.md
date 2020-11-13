In this step, you will create two S3 buckets configured for static website
hosting using a monolithic configuration.

## Configure AWS provider

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

## Review monolithic configuration

Now that you have configured the AWS provider, review the rest of the
configuration found in `main.tf`{{open}}. This configuration will create two S3
buckets, each configured to host a static website, and each containing a single
`index.html`. One bucket will be for your `dev` environment, and the other for
`prod`.

Notice the three variables used in your configuration. Open `variables.tf`{{open}} and notice how these variables are declared with default values.

Now open `outputs.tf`{{open}}, which will output the website endpoints for the two
buckets once Terraform creates them. Later you will use these values to visit the website and verify that your
configuration was successfully deployed.

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

**Note**: If your browser window is wide enough the link may only span one line, in which case it will be clickable from the embedded terminal. 

In the next step, you will begin to organize this configuration by separating
your development and production configuration.
