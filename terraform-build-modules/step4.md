
Whenever you add a new module to a configuration, Terraform must install the
module before it can be used. Both the `terraform get` and `terraform init`
commands will install and update modules. The `terraform init` command will also
initialize backends and install providers.

Now install the module by running `terraform init`{{execute}}.

-> **Note**: When installing a remote module, Terraform will download it into
the `.terraform` directory in your configuration's root directory. When
installing a local module, Terraform will instead refer directly to the source
directory. Because of this, Terraform will automatically notice changes to
local modules without having to re-run `terraform init` or `terraform get`.

Now that your new module is installed and configured, run `terraform apply`{{execute}} to
provision your bucket. After you respond to the prompt with `yes`{{execute}}, 
your bucket and other resources will be provisioned.

## Upload files to the bucket

You have now configured and used your own module to create a static website. You
may want to visit this static website. Right now there is nothing inside your
bucket, so there would be nothing to return if you were to visit the bucket's website. 
In order the bucket website to return any content, you will need to upload 
objects to your bucket. 

The static website files are located in the `/assets/` directory. Upload these
files to the S3 bucket using the [AWS CLI tool](https://aws.amazon.com/cli/).

`aws --endpoint-url=http://localhost:4566 s3 cp assets/ s3://$(terraform output -raw website_bucket_name)/ --recursive`{{execute}}

Note the usage of the `--endpoint-url` parameter -- this configures the AWS CLI
to use the localstack instance of AWS. 

## Verify website endpoint

Verify that the file was uploaded successfully. Because this scenario uses
localstack, the S3 bucket is hosted locally.

Visit the website endpoint below in a web browser. You should find the website
contents, which will be a page that says "Nothing to see here".

`2886795304-4566-kitek05.environments.katacoda.com/terraform-edu-module/index.html`
