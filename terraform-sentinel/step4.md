In this step, you will create testing files and run them in the Sentinel CLI. Sentinel is opinionated about the folder structure required for tests, so creating a specific directory structure for your test files is required. 


## Create a failing test file

Now that you have created a plan in which your Sentinel policy will fail, you need to create a test file for a failing test.

Open `~terraform-sentinel/test/restrict-s3-buckets/fail.json`{{open}} to add a path to the failing mock data.

Copy and paste the failing mock data in your test file relative to your `fail.json` file, in this case, two directories above the current folder in `mock-data`.

```
"mock": {
    "tfplan/v2": "../../mock-data/mock-tfplan-fail-v2.sentinel"
},
```{{copy}}

Review the rest of the test file. This test ensures the main rule will evalute to false.

## Create a passing test file
Open `terraform-sentinel/test/restrict-s3-buckets/pass.json`{{open}} and add a path to the passing mock data that has already been provided for you.

Copy and paste the passing mock data in your test file relative to your `pass.json` file, in this case, two directories above the current folder in `mock-data`.

```
"mock": {
    "tfplan/v2": "../../mock-data/mock-tfplan-pass-v2.sentinel"
},
```{{copy}}

Review the rest of the test file. This test ensures the main rule will evalute to true.

## Run a test in the Sentinel CLI

You now have an automated process for creating a failing scenario for your policies. Instead of running a Sentinel apply in the CLI, you will run a Sentinel test, which evalutes the test data you provided in both your passing and failing cases.

In your terminal, run a test with the `verbose` flag to get the most detailed output of your test scenarios, rather than just "PASS".

```
sentinel test -verbose restrict-s3-buckets.sentinel
```{{execute}}

Now that your failing and passing scenarios are detailed in test files, you can upload these to your VCS policy repo and connect it to your Terraform Cloud organization. Your organization must be subscribed to **Team & Governance** in [Terraform Cloud or Terraform Enterprise](https://www.hashicorp.com/blog/announcing-free-trials-for-hashicorp-terraform-cloud-paid-offerings/) to apply your Sentinel policies to your workspaces. 