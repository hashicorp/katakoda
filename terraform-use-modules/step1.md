Open `main.tf`{{open}}. 

This configuration includes three blocks:

- The `provider "aws"` block defines your provider and region. It 
also includes additional settings that allow this scenario to use 
[localstack](https://localstack.cloud/) to simulate infrastructure, instead of 
requiring you to have an AWS account. Refer to the code in the 
[Learn tutorial](https://learn.hashicorp.com/tutorials/terraform/module-use?in=terraform/modules) 
to build real infrastructure, which will require you to authenticate with AWS. 
- The `module "vpc"` block defines a Virtual Private Cloud (VPC), which will provide networking services for the rest of your infrastructure.
- The `module "ec2_instances"` block defines two EC2 instances within your VPC.

## Use the Terraform Registry

Open the [Terraform Registry page for the VPC
module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.21.0)
in a new browser tab or window.

![Terraform Registry Details Page](./assets/tfr-module-details-top.png)

It provides information about the module, as well as a link to the source
repository. On the right side of the page, you will find a dropdown interface to
select the module version, as well as instructions to use the module to
provision infrastructure.

When calling a module, the `source` argument is required. In this example,
Terraform will search for a module in the Terraform registry that matches the
given string. You could also use a URL or local file path for the source of your
modules. Refer to the [Terraform
documentation](https://www.terraform.io/docs/modules/sources.html) for a list of
possible module sources.

The other argument shown here is the `version`. For supported sources, the
version will let you define what version or versions of the module will be
loaded. In this tutorial, you will specify an exact version number for the modules
you use. You can read about more ways to specify versions in the [module
documentation](https://www.terraform.io/docs/configuration/modules.html#module-versions).

Other arguments to module blocks are treated as input variables to the modules.
