Enable kv-v2 secrets engine at `test`.

```
vault secrets enable -path=test kv-v2
```{{execute T1}}

Create a rate limit quota, "rate-test" with very low settings so that you can see the output when the quota rule is exceeded. Set the rate to `2` against the `test` path.

```
vault write sys/quotas/rate-limit/rate-test path=test rate=1
```{{execute T1}}

Create a shortcut script, `rate-limit-test.sh` which invokes the `test` path.

```
tee rate-limit-test.sh <<EOF
vault kv put test/creds1 pasword="test-password-1"
vault kv put test/creds2 pasword="test-password-2"
vault kv put test/creds3 pasword="test-password-3"
EOF
```{{execute T1}}

Ensure that the script is executable.

```
chmod +x rate-limit-test.sh
```{{execute T1}}

Run the script to see how the quota rule behaves.

```
./rate-limit-test.sh
```{{execute T1}}

The first command complete successfully; however, you should see the following message for the second and third commands in the script.

```
Error writing data to test/data/creds3: Error making API request.

URL: PUT http://127.0.0.1:8200/v1/test/data/creds3
Code: 429. Errors:

 request path "test/data/creds3": rate limit quota exceeded
```

Earlier, you [configured the resource quotas](#configure-resource-quotas) to enable audit logging of requests that were rejected due to rate limit quota rule violation. Inspect your audit log for its entry.

```
more /var/log/vault-audit.log | jq
```{{execute T1}}


You should find an error message indicating that rate limit quota was exceeded that `test-password-3` failed to be written at `test/data/creds3`. You can trace the audit log to see how many requests were rejected due to the rate limit quota. It may be working as expected or you may find suspicious activities against a specific path.

When you are done exploring, delete the `rate-test` quota.

```
vault delete sys/quotas/rate-limit/rate-test
```{{execute T1}}
