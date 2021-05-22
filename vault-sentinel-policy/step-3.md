From the terminal, execute the following command to create a policy `cidr-check`
with enforcement level of **soft-mandatory** to reject requests coming from IP
addressed that are not within the range of the specified CIDR.

```
vault write sys/policies/egp/cidr-check \
        policy=@cidr-check.sentinel \
        paths="secret/data/accounting/*" \
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
path "secret/*" {
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
VAULT_TOKEN=$(cat token.txt) vault kv put secret/accounting/test ID="12345678"
```{{execute}}

```
Error writing data to secret/data/accounting/test: Error making API request.

URL: PUT http://127.0.0.1:8200/v1/secret/data/accounting/test
Code: 403. Errors:

* 1 error occurred:
	* permission denied
```

This is because the `base` policy does **NOT** permit any operations against the
`secret/data/accounting/*` path. In other words, the Vault's policy engine first
evaluates the **ACL policies** attached to the token.
