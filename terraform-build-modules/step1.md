Be sure to work in Terminal 2 for this scenario for the smoothest experience.

Change into the sample code directory.

`cd ~/learn-terraform-modules`{{execute T2}}

Open `main.tf`{{open}}. 

This configuration includes three blocks:

- The `provider "aws"` block defines your defines your provider and region. It 
also includes additional settings that allow this scenario to use 
[localstack](https://localstack.cloud/) to simulate infrastructure, instead of 
requiring you to have an AWS account. Refer to the code in the 
[Learn tutorial](https://learn.hashicorp.com/tutorials/terraform/module-use?in=terraform/modules) 
to build real infrastructure, which will require you to authenticate with AWS. 

- The `module "vpc"` block defines a Virtual Private Cloud (VPC), which will provide networking services for the rest of your infrastructure.
- The `module "ec2_instances"` block defines two EC2 instances within your VPC.
