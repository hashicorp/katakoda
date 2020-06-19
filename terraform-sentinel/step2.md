Now that you have created a policy, you will add some additional restrictions. 

Open the policy file `terraform-sentinel/restrict-s3-buckets.sentinel`{{open}}, and add a print statement.

## Create a print statement for debugging

The print statement is a helpful tool for debugging and discovery when you are writing policies, so create one here after the closing bracket of your `s3_buckets` filter.

```
print(s3_buckets)
```{{copy}}

Run your Sentinel CLI apply again to see what data your filter contains. 

```
sentinel apply -trace restrict-s3-buckets.sentinel
```{{execute}}

Copy the print statement output from your Sentinel apply, which will begin with `"{aws_bucket.bucket:..."` and end with `"..."type":"aws_s3_bucket")}"`. 

Open the `terraform-sentinel/print.json`{{open}} file and paste the print output.

Pipe the contents of this file to a `jq` command in your terminal to make this data easier to read.

```
cat print.json | jq
```{{execute}}

Now, you can view the `resource_changes` collection for your S3 bucket resource as a key/value store.

Remove the print statement from your policy once you have reviewed the output.

## Create a required tags variable

Open the policy file `terraform-sentinel/restrict-s3-buckets.sentinel`{{open}} again.

Copy and paste the `required_tags` variable below your print statement in `terraform-sentinel/restrict-s3-policies.sentinel`{{open}}. You are creating a list of variables that are required to be returned from the data you just generated in the previous print statement.

```
required_tags = [
	"Name",
    "Environment",
]
```{{copy}}

## Create a rule for your required tags

Edit the `bucket_tags` rule to compare to your `require_tags` variable.

```
bucket_tags = rule {
	all s3_buckets as _, buckets {
		all required_tags as rt {
			buckets.change.after.tags contains rt
		}
	}
}
```{{copy}}


## Add an ACL restriction

For S3 buckets, AWS allows you to restrict the level of access to the objects to prevent unauthorized editing. Copy this list of allowed ACLs for your S3 bucket and paste it below your `bucket_tags` rule

```
allowed_acls = [
	"public-read",
	"private",
]
```{{copy}}

## Add a rule for your ACLs

Copy and paste your ACL rule below your `allowed_acls` to evalute the ACL data in your plan.

```
acl_allowed = rule {
	all s3_buckets as _, buckets {
		buckets.change.after.acl in allowed_acls
	}
}
```{{copy}}


## Edit the main rule to evaluate both rules

Your main rule must evaluate both the `acl_allowed` and `bucket_tags` rule. Copy and paste this as your main rule.

```
main = rule {
    (acl_allowed and bucket_tags) else false
}
```{{copy}}

## Run your apply 

Run an apply in the Sentinel CLI again and evaluate the output. You should see that both the `acl_allowed` and `bucket_tags` rules evaluate to true, which allows your `main` rule to evaluate as true and the policy passes.

```
sentinel apply -trace restrict-s3-buckets.sentinel
```{{execute}}

In the next step, you will edit your mock data to create a failing test suite.
