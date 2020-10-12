Now that you have created a policy, you will add some additional restrictions.

Open the policy file `terraform-sentinel/restrict-s3-buckets.sentinel`{{open}}, and add a print statement.

## Create a print statement for debugging

The print statement is a helpful tool for debugging and discovery when you are writing policies, so create one here after the closing bracket of your `s3_buckets` filter.

```
print(s3_buckets)
```{{copy}}

Run your Sentinel CLI apply again to return the filter data in your terminal.

```
sentinel apply -trace restrict-s3-buckets.sentinel
```{{execute}}

Copy the print statement output from your Sentinel apply, which will begin with `"{aws_bucket.bucket:..."` and end with `"..."type":"aws_s3_bucket")}"`.

Create a new file called `terraform-sentinel/print.json`{{open}} and paste the print output there.

Pipe the contents of this file to a `jq` command in your terminal to make this data easier to read.

```
cat print.json | jq
```{{execute}}

Now, you can view the `resource_changes` collection for your S3 bucket resource as a key/value store.

Remove the print statement from your policy once you have reviewed the output.

## Create a required tags variable

Open the policy file `terraform-sentinel/restrict-s3-buckets.sentinel`{{open}} again.

Copy and paste the `required_tags` variable above the `bucket_tags` rule in `terraform-sentinel/restrict-s3-buckets.sentinel`{{open}}. You are creating a list of variables that must be returned from the data you just generated in the previous print statement.

```
required_tags = [
    "Name",
    "Environment",
]
```{{copy}}

## Create a rule for your required tags

Replace the `bucket_tags` rule with a new requirement to compare to your `require_tags` variable.

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

Copy this list of allowed ACLs for your S3 bucket and paste it below your `bucket_tags` rule

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

Your main rule must evaluate both the `acl_allowed` and `bucket_tags` rule. Edit your main rule with these new requirements.

```
main = rule {
    (acl_allowed and bucket_tags) else false
}
```{{copy}}

## Format and apply the policy

Run the `fmt` command to format your policy for clarity.

```
sentinel fmt restrict-s3-buckets.sentinel
```{{execute}}

Close and reopen the `terraform-sentinel/restrict-s3-buckets.sentinel`{{open}} file for your changes to reflect in your editor.

```
sentinel apply -trace restrict-s3-buckets.sentinel
```{{execute}}

In the next step, you will edit your mock data to create a failing test suite.
