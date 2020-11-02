Initialize your Terraform configuration by running `terraform init`{{execute}}. This will install the provider and both of the modules your configuration refers to.

Now run `terraform apply`{{execute}} to create your VPC and EC2 instances.

```
$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.ec2_instances.aws_instance.this[0] will be created
  + resource "aws_instance" "this" {
      + ami                          = "ami-0c5204531f799e0c6"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)

# ...

Plan: 22 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```

You will notice that many more resources than just the VPC and EC2 instances
will be created. The modules we used define what those resources are.

Respond to the prompt with `yes`{{execute}} to apply the changes and continue.

Once the apply step completes, Terraform should display the instance's IP public
IP addresses and the VPC's public subnet ID.

```shell
# ...

Outputs:

ec2_instance_public_ips = [
  "34.220.43.248",
  "34.208.3.72",
]
vpc_public_subnets = [
  "subnet-0ecd7a5db2a78879d",
  "subnet-005a1cfe9fbbf596c",
]
```

## Understand how modules work

When using a new module for the first time, you must run either `terraform init`
or `terraform get` to install the module. When either of these commands are run,
Terraform will install any new modules in the `.terraform/modules` directory
within your configuration's working directory. For local modules, Terraform will
create a symlink to the module's directory. Because of this, any changes to
local modules will be effective immediately, without having to re-run `terraform get`.

After following this tutorial, your `.terraform/modules` directory will look
like the following.

```
.terraform/modules
├── ec2_instances
│   └── terraform-aws-modules-terraform-aws-ec2-instance-ed6dcd9
├── modules.json
└── vpc
    └── terraform-aws-modules-terraform-aws-vpc-2417f60
```