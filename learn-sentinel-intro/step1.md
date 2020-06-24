In this scenario, you will apply Sentinel Policy-as-Code to a Terraform specific deployment. You will create a policy that requires your configuration to have specific tags on S3 buckets and restrict the level of access to bucket objects.

Open the file `terraform-sentinel/tf-config/main.tf`{{open}} and review the infrastructure configuration you are testing.

This configuration builds a publicly-readable S3 bucket with a unique name and deploys an example web app as a bucket object. 

## Review the policy

Open the `terraform-sentinel/restrict-s3-buckets.sentinel`{{open}} file and review the policy for this scenario, which requires you to apply at least one tag to any new or updated S3 bucket.

Run an `apply` with the `trace` flag in your terminal to apply the policy against data from the infrastructure configuration you just reviewed.

```
sentinel apply -trace restrict-s3-buckets.sentinel
```{{execute}}

Review the trace information. You will find that this policy passed because the Terraform plan contained at least one tag and meets the requirements in your `bucket_tags` rule.

## Create a failing policy

To see the failure behavior of your Sentinel policy, change the `bucket_tags` rule to a `null` statement.

```
bucket_tags = rule {
all s3_buckets as _, buckets {
	buckets.change.after.tags is null
	}
}
```{{copy}}

Run an apply in the Sentinel CLI again and evaluate the output. You changed the `bucket_tags` rule to require that NO tags are applied to the S3 bucket. Because your plan information already contains these tags, your policy failed.

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
