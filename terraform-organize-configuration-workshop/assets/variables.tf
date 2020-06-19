variable "aws_region" {
  description = "AWS region for all resources"
  default     = "us-west-2"
}

variable "dev_prefix" {
  description = "Prefix for S3 buckets in the dev environment"
  default     = "dev"
}

variable "prod_prefix" {
  description = "Prefix for S3 buckets in the prod environment"
  default     = "prod"
}
