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

You can find the `lease count quota exceeded` error in the audit log as well.

```
more /var/log/vault-audit.log | jq
```{{execute T2}}

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
