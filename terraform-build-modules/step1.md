Open `main.tf`{{open}}. 

This configuration includes three blocks:

- The `"aws" provider` defines your provider. This Katacoda scenario uses [localstack](https://localstack.cloud/) to provide a 
testing environment on your local machine that provides the same functionality 
and APIs as the real AWS cloud environment. This way you can learn how to organize
your Terraform configuration without needing an AWS account.

  As a result, the AWS provider block will have additional boilerplate which isn't required for a standard Terraform AWS workflow.
  
  Refer to the [AWS Get Started collection](https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started) or the [AWS Provider Registry page](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication) to learn different ways  to authenticate the AWS provider.
- The `"vpc" module` defines a Virtual Private Cloud (VPC), which will provide networking services for the rest of your infrastructure.
- The `"ec2_instances" module` defines two EC2 instances within your VPC.