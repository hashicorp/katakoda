In this step, you will edit your mock data structure to create a failing scenario based on the requirements in the policy. The passing test requires two tags and only allows for specific ACLs, so a failing test will have neither of those tags and have a more permissive ACL.

## Open the failing mock scenario for editing

Open `terraform-sentinel/mock-data/mock-tfplan-fail-v2.sentinel`{{open}} and edit the values for your failing test. This file is a copy of your original mock data, but with a different file name to allow you to edit it with values that will cause your policy to fail. Creating a known "passing" and "failing" mock file in your mock-data directory keeps all your plan imports in the same folder structure.

## Edit your mock data ACL

Your mock data contains the ACL for the configuration in the `resource_changes` collection. Instead of `public-read`, which is allowed in your policy, change this to `public-read-write` to create a failing scenario for your `acl_allowed` rule.

Scroll to line 122 and update the value by clicking "Copy to Editor."

<pre class="file" data-filename="terraform-sentinel/mock-data/mock-tfplan-fail-v2.sentinel" data-target="insert" data-marker="#ACL">public-read-write</pre>

## Edit your mock data tags

To create a failing scenario for your `bucket_tags` rule, replace the tag identifiers in the `resource_changes` collection with different values. These tag identifiers search for an exact match so any additional text will cause a failure.

Scroll to line 133 and edit the `Name` tag key to `Organization` by clicking the "Copy to Editor" button.

<pre class="file" data-filename="terraform-sentinel/mock-data/mock-tfplan-fail-v2.sentinel" data-target="insert" data-marker="#Name">Organization</pre>

On line 134, edit the `Environment` tag key to `Workspace` by clicking the "Copy to Editor" button.

<pre class="file" data-filename="terraform-sentinel/mock-data/mock-tfplan-fail-v2.sentinel" data-target="insert" data-marker="#Environment">Workspace</pre>

Now that you have failing mocked data, the next step will show you how to implement this in your failing tests.
