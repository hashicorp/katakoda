Now that you have created your module, return to the `main.tf`{{open}} in your root
configuration and add a reference to the new module.

<pre class="file" data-target="clipboard">
module "website_s3_bucket" {
  source = "./modules/aws-s3-static-website-bucket"

  bucket_name = "terraform-edu-modules"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
</pre>

AWS S3 buckets names must be globally unique. However, since this scenario uses
`localstack` to mock the AWS services, adding this snippet directly into your 
`main.tf` is ok.

In this example, the `bucket_name` and `tags` arguments are passed to the
module, and provide values for the matching variables found in
`modules/aws-s3-static-website-bucket/variables.tf`.

## Define outputs

Earlier, you added several outputs to the `aws-s3-static-website-bucket` module,
making those values available to your root configuration.

Add these values as outputs to your root module by adding the following to
the `outputs.tf`{{open}} file in your root module directory (not the one in
`modules/aws-s3-static-website-bucket`).

<pre class="file" data-target="clipboard">
output "website_bucket_arn" {
  description = "ARN of the bucket"
  value       = module.website_s3_bucket.arn
}

output "website_bucket_name" {
  description = "Name (id) of the bucket"
  value       = module.website_s3_bucket.name
}

output "localstack_bucket_index_file" {
  description = "Location of index file in localstack bucket"
  value       = "${module.website_s3_bucket.name}.localhost:4566/${module.website_s3_bucket.name}/index.html"
}
</pre>
