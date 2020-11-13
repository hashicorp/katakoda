
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

`aws s3 cp assets/ s3://$(terraform output website_bucket_name)/ --recursive`{{execute}}

## Verify website endpoint

Verify that the file was uploaded successfully. Because this scenario uses
localstack, the S3 bucket is hosted locally.

Get the bucket name.

`terraform output website_bucket_name`{{execute}}

Then, visit the website endpoint in a web browser, replacing `<BUCKET_NAME>` 
with your bucket name. You should find the website contents.

`[[HOST_SUBDOMAIN]]-4566-[[KATACODA_HOST]].environments.katacoda.com/${module.website_s3_bucket.name}/index.html`