Change into the `workshop-one` folder to run the tests.

```shell
cd workshop-one
```{{execute}}

Run the tests.

```shell
sentinel test
```{{execute}}

Explore the test failure error message.

```
FAIL - cidr-check.sentinel
  PASS - test/cidr-check/fail.json
  FAIL - test/cidr-check/success.json
    rule "main" not found in trace for policy cidr-check.sentinel

    trace:

      FALSE - cidr-check.sentinel:5:1 - Rule "precond"
        FALSE - cidr-check.sentinel:6:5 - request.operation in ["create", "update", "delete"]
```

The failure case in `fail.json` is passing, but the success case is not.

You can compare the code in the `cidr-check.sentinel` policy file with that in the `success.json` test to troubleshoot and resolve the test error.
