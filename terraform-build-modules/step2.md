Create a directory named `modules`, with a directory called 
`aws-s3-static-website-bucket` inside of it.

`mkdir -p modules/aws-s3-static-website-bucket`{{execute T2}}

After creating these directories, your configuration's directory structure 
should look like the following.

```
.
├── LICENSE
├── README.md
├── main.tf
├── modules
│   └── aws-s3-static-website-bucket
├── assets
│   └── index.html
│   └── error.html
├── outputs.tf
└── variables.tf
```

## Create a README.md and LICENSE

While neither the `README.md` nor `LICENSE` files are required or used by 
Terraform. Having them is a best practice for modules that may one day be 
shared with others.

Inside the `aws-s3-static-website-bucket` directory, create a file called
`README.md` with the following content.

`touch modules/aws-s3-static-website-bucket/README.md`{{execute T2}}

Open `modules/aws-s3-static-website-bucket/README.md`{{open}} and paste in
the contents below.

<pre class="file" data-target="clipboard">
# AWS S3 static website bucket

This module provisions AWS S3 buckets configured for static website hosting.
</pre>

Choosing the correct license for your modules is out of the scope of this 
tutorial. This tutorial will use the Apache 2.0 open source license.

Create another file called LICENSE.

`touch modules/aws-s3-static-website-bucket/LICENSE`{{execute T2}}

Open `modules/aws-s3-static-website-bucket/LICENSE`{{open}} and paste in
the contents below.

<pre class="file" data-target="clipboard">
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
</pre>

## Add module configuration

Create the `main.tf` configuration file for the module. 

`touch modules/aws-s3-static-website-bucket/main.tf`{{execute T2}}

Add the following to `modules/aws-s3-static-website-bucket/main.tf`{{open}}. This configuration creates a public S3 bucket hosting a website with an index page and an error page.

<pre class="file" data-target="clipboard">
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name

  acl    = "public-read"
  policy = &lt;&lt;EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.bucket_name}/*"
            ]
        }
    ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = var.tags
}
</pre>

Notice that there is no `provider` block in this configuration. When
Terraform processes a module block, it will inherit the provider from the
enclosing configuration. Because of this, we recommend that you do not include
`provider` blocks in modules.

Just like the root module of your configuration, modules will define and use
variables.

### Create variables file

Next, create the `variables.tf` file.

`touch modules/aws-s3-static-website-bucket/variables.tf`{{execute T2}}

Define the following variables in the
`modules/aws-s3-static-website-bucket/variables.tf`{{open}} file.

<pre class="file" data-target="clipboard">
variable "bucket_name" {
  description = "Name of the s3 bucket. Must be unique."
  type = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type = map(string)
  default = {}
}
</pre>

Variables within modules work almost exactly the same way that they do for the
root module. When you run a Terraform command on your root configuration, there
are various ways to set variable values, such as passing them on the
commandline, or with a `.tfvars` file. When using a module, variables are set by
passing arguments to the module in your configuration. You will set some of
these variables when calling this module from your root module's `main.tf`.

Variables defined in modules that aren't given a default value are required, and
so must be set whenever the module is used.

When creating a module, consider which resource arguments to expose to module
end users as input variables. For example, you might decide to expose the index
and error documents to end users of this module as variables, but not define a
variable to set the ACL, since to host a website your bucket will need the ACL
to be set to "public-read".

You should also consider which values to add as outputs, since outputs are the
only supported way for users to get information about resources configured by
the module.

### Create output file

Add outputs to your module in the `outputs.tf` file inside the
`modules/aws-s3-static-website-bucket` directory.

Now, create the `outputs.tf` file.

`touch modules/aws-s3-static-website-bucket/outputs.tf`{{execute T2}}

Add outputs to your module in
`modules/aws-s3-static-website-bucket/outputs.tf`{{open}} file.  

<pre class="file" data-target="clipboard">
# Output variable definitions

output "arn" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.s3_bucket.arn
}

output "name" {
  description = "Name (id) of the bucket"
  value       = aws_s3_bucket.s3_bucket.id
}

output "website_endpoint" {
  description = "Domain name of the bucket"
  value       = aws_s3_bucket.s3_bucket.website_endpoint
}
</pre>

Like variables, outputs in modules perform the same function as they do in the
root module but are accessed in a different way. A module's outputs can be
accessed as read-only attributes on the module object, which is available within
the configuration that calls the module. You can reference these outputs in
expressions as `module.<MODULE NAME>.<OUTPUT NAME>`.
