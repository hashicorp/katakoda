In this step, you will create testing files and run them in the Sentinel CLI

# Create a failing test file

Now that you have created a plan in which your Sentinel policy will fail, you need to create test file for a failing test.

Open `terraform-sentinel/test/restrict-s3-buckets/fail.json`{{open}} to create a path to the failing mock data.

Copy and paste the relative path to your failing mock in the test file.

```
{
  "mock": {
    "tfplan/v2": "../../mock-data/mock-tfplan-fail-v2.sentinel"
  },
```{{copy}}

Review the rest of the test file. This test ensures the main rule will evalute to false.

# Create a passing test file
Open `terraform-sentinel/test/restrict-s3-buckets/pass.json`{{open}} and create a path to the passing mock data that has already been provided for you.

Copy and paste the relative path to your passing mock in the test file.

```
{
  "mock": {
    "tfplan/v2": "../../mock-data/mock-tfplan-pass-v2.sentinel"
  },
```{{copy}}

Review the rest of the test file. This test ensures the main rule will evalute to true.

# Run a test in the Sentinel CLI

In your terminal, run a test with the `verbose` flag

```
sentinel test -verbose restrict-s3-buckets.sentinel
```{{execute}}

Now that you failing and passing scenarios are detailed in test files, you can create upload these to your VCS provider connected to your Terraform Cloud organization. 