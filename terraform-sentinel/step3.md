In this step, you will edit your mock data structure to create a failing scenario based on the requirements in the policy. The passing test requires two tags and only allows for specific ACLs, so a failing test will have neither of those tags and have an ACL outside the bounds of your policy.

## Open the failing mock scenario for editing

Open `~/terraform-sentinel/mock-data/mock-tfplan-fail-v2.sentinel`{{open}} and edit the values for your failing test.

## Edit your mock data ACL

Your mock data contains the ACL for the configuration. Instead of `public-read`, which is allowed in your policy, change this to `public-read-write`. 

If you are having trouble finding the specific line in the collection, search for `<UPDATE_VALUE1>` in the file and overwrite it with `"public-read-write",`{{copy}}

## Edit your mock data tags

Review the mock data provided for you. `~/terraform-sentinel/mock-data/mock-tfplan-v2.sentinel`{{open}}

To create a failing scenario, replace the tag identifiers with different values. These tag identifiers search for an exact match so any additional text will cause a failure. 

If you have trouble finding the specific line, search for `<UPDATE_ID1>` and replace it with `"FAIL-Environment`{{copy}}

Search for `<UPDATE_ID2>` and overwrite it with `"FAIL-Name`{{copy}}

Now that you have failing mocked data, the next step will show you how to implement this in your failing tests.