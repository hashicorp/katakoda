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

The first two commands complete successfully; however, you should see the following message for the third command in the script.

```
Error writing data to test/data/creds3: Error making API request.

URL: PUT http://127.0.0.1:8200/v1/test/data/creds3
Code: 429. Errors:

 request path "test/data/creds3": rate limit quota exceeded
```

Earlier, you [configured the resource quotas](#configure-resource-quotas) to enable audit logging of requests that were rejected due to rate limit quota rule violation. Inspect your audit log for its entry.

```
tail -f /var/log/vault-audit.log | jq
```{{execute T1}}


You should find an error message indicating that rate limit quota was exceeded that `test-password-3` failed to be written at `test/data/creds3`. You can trace the audit log to see how many requests were rejected due to the rate limit quota. It may be working as expected or you may find suspicious activities against a specific path.

When you are done exploring, delete the `rate-test` quota.

```
vault delete sys/quotas/rate-limit/rate-test
```{{execute T1}}

## Lease count quota test

Similarly, create a very limited lease count quota named, "lease-test" which applies on the `root` level. It only allows 3 tokens and leases to be stored.

```
vault write sys/quotas/lease-count/lease-test max_leases=3
```{{execute T1}}

To create a `root` level quota rule, simply do not set the target `path`.

Create a shortcut script, `lease-count-test.sh` which invokes the `test` path.

```
tee lease-count-test.sh <<EOF
vault token create -policy=default
vault token create -policy=default
vault token create -policy=default
vault token create -policy=default
EOF
```{{execute T1}}

Make sure that the script is executable.

```
chmod +x lease-count-test.sh
```{{execute T1}}

Run the script to see how the quota rule behaves.

```
./lease-count-test.sh
```{{execute T1}}

Three tokens were created successfully; however, the fourth request failed due to the lease count quota. Your output should look similar to follow.

If you revoke one of the tokens, you should be able to request a new one.

**Example:**

```
vault token revoke s.MdcsHZEsbhogH4zIIcjtLYJk

Success! Revoked token (if it existed)
```

Now, request a new one.

```
vault token create -policy=default
```{{execute T1}}

The best practice is to set the tokens and leases' time-to-live (TTL) to be short and don't let them hang around longer than necessary. The lease count quotas allow you to set the upper limit to protect your Vault environment from running into an issue due to a lack of token and lease governance.

When you are done exploring, delete the `lease-test` quota rule.

```
vault delete sys/quotas/lease-count/lease-test
```{{execute T1}}
