In this scenario, you will apply the Sentinel logic principles to a Terraform specific deployment.

Navigate to the `terraform-sentinel/tf-config/main.tf`{{open}} and review the configuration you are testing.

This configuration builds an S3 bucket with a unique name and deploys an example web app as a bucket object. You have an S3 bucket policy attached to the bucket resource which allows pubic read permissions for your bucket object. This example configuration does not have any deployment safeguards built in and if your AWS user has S3 build and upload permissions, your Terraform deployment will apply successfully.

Proper testing of a policy requires that these values be able to be mocked - or, in other words, simulated in a way that allows the accurate testing of the scenarios that a policy could reasonably pass or fail under.

In order to test this policy, this scenario has pre-generated [mock data from Terraform Cloud](https://www.terraform.io/docs/cloud/sentinel/mock.html). To learn how to generate mock data for testing in the Sentinel CLI, follow the [Sentinel Learn guides on Sentinel & Terraform Cloud](https://www.learn.hashicorp.com/terraform?LINK).

Part of writing Sentinel policies is to determine your parameters based on your infrastructure. For your first policy, you must ensure the following: 

- Any S3 buckets created or updated have at least 1 tag

## Create a filter

The stub of this policy is in `terraform-sentinel/restrict-s3-buckets.sentinel`{{open}}.

The first step in this policy relies on creating a filter for the s3_bucket resources in the Terraform Cloud plan. Copy and paste the filter block below the import statement.

```
s3_buckets = filter tfplan.resource_changes as _, rc {
	rc.type is "aws_s3_bucket" and
		(rc.change.actions contains "create" or rc.change.actions is ["update"])
		}
```{{copy}}


## Create the bucket rule

Your policy has a filter that will search the mock data, but no rule to evaluate this data against. Copy and paste the `bucket_tags` rule to your policy below the filter statement.

```
bucket_tags = rule {
	all s3_buckets as _, buckets {
		buckets.change.after.tags is not null
		}
	}
	```{{copy}}


## Create main rule

Your filter and bucket rule will be evaluated in the main rule. Copy and paste the main rule below your bucket rule.

```
main = rule {
    bucket_tags else false
}
```{{copy}}

## Run your first apply

To see Sentinel policy logic in action, run an `apply` with the `trace` flag in your terminal.

```
sentinel apply -trace restrict-s3-buckets.sentinel
```{{execute}}

Review the trace information.

## Create a failing policy

To see the failure behavior of your Sentinel policy, change the `bucket_tags` rule to a `null` statement.

```
bucket_tags = rule {
	all s3_buckets as _, buckets {
		buckets.change.after.tags is null
		}
	}
	```{{copy}}

Run an apply in the Sentinel CLI again and evaluate the output.

```
sentinel apply -trace restrict-s3-buckets.sentinel
```{{execute}}

After reviewing the failing output, change the `bucket_tags` rule to evaluate correctly.

```
bucket_tags = rule {
	all s3_buckets as _, buckets {
		buckets.change.after.tags is not null
		}
	}
	```{{copy}}

In the next step, you will build on this policy with more specific and restrictive policy information.