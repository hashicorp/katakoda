View the policy file named `common_policy.hcl`{{open}}.

This policy file is writen in HCL. The `length` field sets the length of the
password returned to `20` charaters. Each rule stanza defines a character set
and the minimum number of occurences those characters need to appear in the
generated password. These rules are cumulative so each one adds more
requirements on the password generated.

Create a password policy named `common_policy` with the requirements defined
in the `common_policy.hcl` policy file.

```shell
vault write sys/policies/password/common_policy policy=@common_policy.hcl
```{{execute}}

Generate a password from the policy.

```shell
vault read sys/policies/password/common_policy/generate
```{{execute}}
