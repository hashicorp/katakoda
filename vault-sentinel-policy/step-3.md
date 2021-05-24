From the terminal, execute the following command to create a policy `cidr-check`
with enforcement level of **soft-mandatory** to reject requests coming from IP
addressed that are not within the range of the specified CIDR.

```
vault write sys/policies/egp/cidr-check \
        policy=@cidr-check.sentinel \
        paths="kv/*" \
        enforcement_level="soft-mandatory"
```{{execute}}

You can read the policy by executing the following command:

```
vault read sys/policies/egp/cidr-check
```{{execute}}

## Validate

First, create a `base` policy.

```
vault policy write base -<<EOF
path "kv/*" {
   capabilities = ["create", "update", "list"]
}
EOF
```{{execute}}

Create a token attached with the `base` policy.

```
vault token create -policy="base" \
    -format=json | jq -r ".auth.client_token" > token.txt
```{{execute}}

Copy the generated token value.

Try and see what happens if you attempt to write some data at
`secret/accounting/test` path using the token you created at _Step 3.3.6_.


```
VAULT_TOKEN=$(cat token.txt) vault kv put kv/accounting/test ID="12345678"
```{{execute}}

```
Error writing data to kv/accounting/test: Error making API request.

URL: PUT http://127.0.0.1:8200/v1/kv/accounting/test
Code: 403. Errors:

* 2 errors occurred:
        * egp standard policy "root/cidr-check" evaluation resulted in denial.

The specific error was:
<nil>

A trace of the execution for policy "root/cidr-check" is available:

Result: false

Description: Check the precondition before executing the cidrcheck

Rule "main" (byte offset 442) = false
  false (offset 312): sockaddr.is_contained(request.connection.remote_addr, "122.22.3.4/32")

Rule "cidrcheck" (byte offset 289) = false

Rule "precond" (byte offset 113) = true
  true (offset 134): request.operation in ["create", "update", "delete"]
  true (offset 194): strings.has_prefix(request.path, "kv/")


Note: specifying an override of the operation would have succeeded.
        * permission denied
```

This is because the `base` policy does **NOT** permit any operations against the
`secret/data/accounting/*` path. In other words, the Vault's policy engine first
evaluates the **ACL policies** attached to the token.
