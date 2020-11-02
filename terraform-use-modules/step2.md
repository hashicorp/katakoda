In this step, you will set and define the module input variables.

## Review values for module input variables

In order to use most modules, you will need to pass input variables to the
module configuration. The configuration that calls a module is responsible for
setting its input values, which are passed as arguments in the module block.
Aside from `source` and `version`, most of the arguments to a module block will
set variable values.

On the Terraform registry page for the AWS VPC module, you
will see an `Inputs` tab that describes all of the [input variables](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.21.0?tab=inputs)
that module supports.

Some input variables are _required_, meaning that the module doesn't provide a
default value — an explicit value must be provided in order for Terraform to
run correctly.

### Review VPC module variables

Within the `"vpc" module` block, review the input variables. You
can find each of these input variables documented [in the Terraform
registry](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.21.0?tab=inputs)

- `name` will be the name of the VPC within AWS.
- `cidr` describes the CIDR blocks used within your VPC.
- `azs` are the availability zones that will be used for the VPC's subnets.
- `private_subnets` are subnets within the VPC that will contain resources that
  do not have a public IP address or route.
- `public_subnets` are subnets that will contain resources with public IP
  addresses and routes.
- `enable_nat_gateway` if _true_, the module will provision NAT gateways for
  your private subnets.
- `tags` specify the tags for each of the resources provisioned by this
  configuration within AWS.

### Review EC2 instance module variables

Next, review the arguments for the `"ec2_instances" module` block by
comparing them to [the module
documentation](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/2.12.0?tab=inputs).

When creating EC2 instances, you need to specify a subnet and security group for
them to use. This example uses the ones provided by the VPC module.

## Define root input variables

Using input variables with modules is very similar to how you use variables in
any Terraform configuration. A common pattern is to identify which module input
variables you might want to change in the future, and create matching variables
in your configuration's `variables.tf` file with sensible default values. Those
variables can then be passed to the module block as arguments.

Not all module input variables need to be set using variables in your
configuration. For instance, you might want this VPC to always have a NAT
gateway enabled, because the application you are provisioning requires it. In
that case, using a variable to set `enable_nat_gateway` would be
counterproductive.

You will need to define these variables in your configuration to use them.

Open `variables.tf`{{open}}. This file should contain the following.

```hcl
# Input variable definitions

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "example-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type    = bool
  default = true
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default     = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Define root output values

Modules also have output values, which are defined within the module with the
`output` keyword. You can access them by referring to `module.<MODULE NAME>.<OUTPUT NAME>`. Like input variables, module outputs are listed under the
`outputs` tab in the [Terraform
registry](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.21.0?tab=outputs).

Module outputs are usually either passed to other parts of your configuration,
or defined as outputs in your root module. You will see both uses in this tutorial.

Open `outputs.tf`{{open}}. This file should contain the following.

```hcl
output "vpc_public_subnets" {
  description = "IDs of the VPC's public subnets"
  value       = module.vpc.public_subnets
}

output "ec2_instance_public_ips" {
  description = "Public IP addresses of EC2 instances"
  value       = module.ec2_instances.public_ip
}
```

In this example, the value of the `vpc_public_subnets` will come from the
`public_subnets` output from the module named `vpc`, and
`ec2_instance_public_ips` is defined as `module.ec2_instances.public_ip`.