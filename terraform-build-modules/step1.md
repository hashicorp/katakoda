Open `main.tf`{{open}}. 

This configuration includes three blocks:

- The `provider "aws"` block defines your provider. This Katacoda scenario uses 
[localstack](https://localstack.cloud/) to provide a testing environment with 
similar functionality and APIs as the real AWS cloud environment. This way you can 
learn how to organize your Terraform configuration without needing an AWS account.

  As a result, the AWS provider block will have additional boilerplate which isn't required for a standard Terraform AWS workflow.

- The `module "vpc"` block defines a Virtual Private Cloud (VPC), which will provide networking services for the rest of your infrastructure.
- The `module "ec2_instances"` block defines two EC2 instances within your VPC.