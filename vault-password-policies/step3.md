View the policy file named `example_policy.hcl`{{open}}.

This policy file is writen in HCL. The `length` field sets the length of the
password returned to `20` charaters. Each rule stanza defines a character set
and the minimum number of occurences those characters need to appear in the
generated password. These rules are cumulative so each one adds more
requirements on the password generated.

Create a password policy named `example` with the requirements defined
in the `example_policy.hcl` policy file.

```shell
vault write sys/policies/password/example policy=@example_policy.hcl
```{{execute}}

Generate a password from the policy.

```shell
vault read sys/policies/password/example/generate
```{{execute}}
