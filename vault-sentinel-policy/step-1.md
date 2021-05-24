First, setup the environment by executing the `setup.sh` script.

```
clear
chmod +x setup.sh
./setup.sh
```{{execute}}

Change the working directory to `sentinel`.

```
cd sentinel
```{{execute}}

The`sentinel/cidr-check.sentinel`{{open}} file and its test cases are provided.

Run the tests.

```shell
clear
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
        TRUE - cidr-check.sentinel:6:5 - request.operation in ["create", "update", "delete"]
        FALSE - cidr-check.sentinel:7:5 - strings.has_prefix(request.path, "kv/")
```

The failure case defined in `fail.json` is passing, but the success case is not.

> **Question:** Why did the test fail? Do the sentinel policy and its test case match?


## Troubleshoot the test

Open `sentinel/cidr-check.sentinel`{{open}} in the editor to examine the code.

Also, open `sentinel/test/cidr-check/success.json`{{open}} and compare with policy.


Make necessary updates, and run the test again.

```shell
sentinel test
```{{execute}}
