
Whenever you add a new module to a configuration, Terraform must install the
module before it can be used. Both the `terraform get` and `terraform init`
commands will install and update modules. The `terraform init` command will also
initialize backends and install plugins.

Now install the module by running `terraform init`.

```shell-session
$ terraform init
```


-> **Note**: When installing a remote module, Terraform will download it into
the `.terraform` directory in your configuration's root directory. When
installing a local module, Terraform will instead refer directly to the source
directory. Because of this, Terraform will automatically notice changes to
local modules without having to re-run `terraform init` or `terraform get`.

Now that your new module is installed and configured, run `terraform apply` to
provision your bucket. After you respond to the prompt with `yes`{{execute}}, 
your bucket and other resources will be provisioned.

```shell-session
$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

# ...

  # module.website_s3_bucket.aws_s3_bucket.s3_bucket will be created
  + resource "aws_s3_bucket" "s3_bucket" {
      + acceleration_status         = (known after apply)

# ...

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```

## Upload files to the bucket

You have now configured and used your own module to create a static website. You
may want to visit this static website. Right now there is nothing inside your
bucket, so there would be nothing to see if you visit the bucket's website. In
order to see any content, you will need to upload objects to your bucket. 

First, download the `index.html` and `error.html` files from the [the GitHub
repository](https://github.com/hashicorp/learn-terraform-modules/tree/master/modules/aws-s3-static-website-bucket/www).

`curl -O https://raw.githubusercontent.com/hashicorp/learn-terraform-modules/master/modules/aws-s3-static-website-bucket/www/index.html`{{execute}}
`curl -O https://raw.githubusercontent.com/hashicorp/learn-terraform-modules/master/modules/aws-s3-static-website-bucket/www/error.html`{{execute}}

Then, upload both files to the S3 bucket using the [AWS CLI tool](https://aws.amazon.com/cli/).

`aws s3 cp index.html s3://$(terraform output website_bucket_name)/`{{execute}}
`aws s3 cp error.html s3://$(terraform output website_bucket_name)/`{{execute}}

## Verify website endpoint

Verify that the file was uploaded successfully. Because this scenario uses
localstack, the S3 bucket is hosted locally.

Get the bucket name.

`terraform output website_bucket_name`{{execute}}

Then, visit the website endpoint in a web browser, replacing `<BUCKET_NAME>` 
with your bucket name. You should see the website contents.

`[[HOST_SUBDOMAIN]]-4566-[[KATACODA_HOST]].environments.katacoda.com/${module.website_s3_bucket.name}/index.html`