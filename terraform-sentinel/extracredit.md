In this extra credit scenario, you will refactor your existing policy into a module.

Modules allow you to re-use Sentinel code as an import. This allows you to package code that is useful across multiple policies, making final policy code simpler.

Your module will move the `bucket` and `acl` rules into a separate file so they can be used in other policies.

# Create a modules directory

Create a new `modules` directory.

`mkdir modules`{{execute}}

Move your policy to this directory as a new file.

`mv restrict-s3-buckets.sentinel modules/restrict.sentinel`{{execute}}

Remove the `main` rule.

## Update your module path

You created a new directory for your policy modules. Sentinel requires the path to this directory in `sentinel.hcl` to access it as an import.

Open `terraform-sentinel/sentinel.hcl`{{open}} and add the `modules` path to your new module under the `mock` paths. Replace the contents of this file with the complete file below by clicking "Copy to Editor."

<pre class="file" data-filename="terraform-sentinel/sentinel.hcl" data-target="replace" >mock "tfplan/v2" {
  module {
    source = "mock-data/mock-tfplan-v2.sentinel"
  }
}

module "restrict" {
  source = "./modules/restrict.sentinel"
}</pre>


## Create a new root policy

Create a new policy file `terraform-sentinel/root.sentinel`{{open}} and add the module as an `import` statement by clicking "Copy to Editor."

<pre class="file" data-filename="terraform-sentinel/root.sentinel" data-target="append" >import "restrict"</pre>

Create a new main rule that accesses this module as an import by clicking "Copy to Editor."

<pre class="file" data-filename="terraform-sentinel/root.sentinel" data-target="append" >main = rule {
    (restrict.acl_allowed and restrict.bucket_tags) else false
}</pre>

Run your Sentinel `apply` with the new `root.sentinel` file as the target policy.

```
sentinel apply -trace root.sentinel
```{{execute}}


## Create a custom function in your policy

Functions allow you to create reusable code within your policies. Sentinel has several built-in functions, like `print`; however, you can also create your own custom functions.

Instead of hard-coding a specific resource, you will create a function to find resources based on the type you define.

The function you will create in this section will replace the `s3_buckets` filter with a function to search for any resource you define and then call that function in other policies.

Create a new file `terraform-sentinel/modules/find_resources.sentinel`{{open}}. Add the function below by clicking "Copy to Editor."

<pre class="file" data-filename="terraform-sentinel/find_resources.sentinel" data-target="append" >import "tfplan/v2" as tfplan

find_resources = func(type) {
  resources = filter tfplan.resource_changes as _, rc {
    rc.type is type and
  	rc.mode is "managed" and
  	(rc.change.actions contains "create" or rc.change.actions contains "update")
  }
  return resources
}</pre>


This function iterates over a filter, but takes a `type` argument that you can access from another module.

## Create a module to access your function

This function is not accessed anywhere yet. Instead of hard-coding the resource type into your policy, create a new module.

Open `terraform-sentinel/modules/buckets.sentinel`{{open}} and add the module below by clicking "Copy to Editor."

<pre class="file" data-filename="terraform-sentinel/buckets.sentinel" data-target="append" >import "find_resources"

found_buckets = find_resources.find_resources("aws_s3_bucket")

required_tags = [
    "Name",
    "Environment",
]

bucket_tags = rule {
all found_buckets as _, buckets {
    all required_tags as rt {
        buckets.change.after.tags contains rt
        }
    }
}

allowed_acls = [
    "public-read",
    "private",
]

acl_allowed = rule {
    all found_buckets as _, buckets {
    buckets.change.after.acl in allowed_acls
    }
}</pre>


This module does several things:

* Your `import` statement imports your previous `function`
* The `found_buckets` variable uses that import function and searches for the `type` string you define.
* The rules search through the `found_buckets` variable.

## Update your configuration file

Open `terraform-sentinel/sentinel.hcl`{{open}} to add the paths for your new files.

Replace the contents of this file with the paths below by clicking "Copy to Editor."

<pre class="file" data-filename="terraform-sentinel/sentinel.hcl" data-target="replace" >mock "tfplan/v2" {
  module {
    source = "mock-data/mock-tfplan-v2.sentinel"
  }
}

module "find_resources" {
  source = "./modules/find_resources.sentinel"
}


module "buckets" {
  source = "./modules/buckets.sentinel"
}</pre>

You have two module paths for Sentinel to access now.

## Update your root rule

Open `terraform-sentinel/root.sentinel`{{open}} and replace the contents with the information below by clicking "Copy to Editor."

<pre class="file" data-filename="terraform-sentinel/root.sentinel" data-target="replace" >import "buckets"

main = rule {
    (buckets.acl_allowed and buckets.bucket_tags) else false
}</pre>


You have one import statement to access the `buckets` module and your main rule references that import to give your policy its central logic.

Run your Sentinel `apply` with the new `root.sentinel` file as the target policy.

```
sentinel apply -trace root.sentinel
```{{execute}}
