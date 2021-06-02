Now that you have created a policy, you will add some additional restrictions.

## Create a print statement for debugging

The print statement is a helpful tool for debugging and discovery when you are writing policies. Click "Copy to Editor" to add the print statement to your policy.

<pre class="file" data-filename="terraform-sentinel/restrict-s3-buckets.sentinel" data-target="append">

print(s3_buckets)
</pre>

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

You will add a new variable to your `terraform-sentinel/restrict-s3-buckets.sentinel`{{open}} policy. Click the "Copy to Editor" button to add the `required_tags` variable into your policy. You are creating a list of variables that must be returned from the data you just generated in the previous print statement.

<pre class="file" data-filename="terraform-sentinel/restrict-s3-buckets.sentinel" data-target="insert" data-marker="# Rule to require at least one tag">

# Rule to require specific tags

required_tags = [
    "Name",
    "Environment",
]

</pre>


## Create a rule for your required tags

Click the "Copy to Editor" button to update your `bucket-tags` rule with the `required_tags` parameter.

<pre class="file" data-filename="terraform-sentinel/restrict-s3-buckets.sentinel" data-target="insert" data-marker="
bucket_tags = rule {
    all s3_buckets as _, buckets {
    buckets.change.after.tags is not null
    }
}
">
bucket_tags = rule {
all s3_buckets as _, buckets {
    all required_tags as rt {
        buckets.change.after.tags contains rt
        }
    }
}

# ACL restriction
</pre>


## Add an ACL restriction

Click the "Copy to Editor" button to add a list of allowed ACLs to your policy.

<pre class="file" data-filename="terraform-sentinel/restrict-s3-buckets.sentinel" data-target="insert" data-marker="# ACL restriction
"># ACL restriction

allowed_acls = [
	"public-read",
	"private",
]

# ACL restriction rule

</pre>

## Add a rule for your ACLs

Click the "Copy to Editor" button to add an `allowed_acls` rule to evalute the ACL data in your plan.

<pre class="file" data-filename="terraform-sentinel/restrict-s3-buckets.sentinel" data-target="insert" data-marker="# ACL restriction rule">

# ACL restriction rule

acl_allowed = rule {
	all s3_buckets as _, buckets {
	buckets.change.after.acl in allowed_acls
	}
}</pre>


## Edit the main rule to evaluate both rules

Your main rule must evaluate both the `acl_allowed` and `bucket_tags` rule. Click the "Copy to Editor" button to update your main rule with these restrictions.

<pre class="file" data-filename="terraform-sentinel/restrict-s3-buckets.sentinel" data-target="insert" data-marker="# Main rule that requires other rules to be true
main = rule {
    bucket_tags else false
}
"># Main rule that requires other rules to be true
main = rule {
    (acl_allowed and bucket_tags) else false
}
</pre>

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
