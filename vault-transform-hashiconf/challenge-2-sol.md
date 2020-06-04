There is more than one approach to solve the challenge, and this ***sample*** solution.

Step 1: Create a `swiss-phone` transformation

```
vault write transform/transformation/swiss-phone type=masking \
        template=phone-number-tmpl allowed_roles=*
```{{execute T1}}


Create a template named "swiss-phone-tmpl" that satisfy the requirements.

```
vault write transform/template/phone-number-tmpl type=regex \
        pattern="\d{3} (\d{3}) (\d{2}) (\d{2})" \
        alphabet=builtin/numeric
```{{execute T1}}



## Validation

Test the transformation with some dummy phone number.

```
vault write transform/encode/payments value="022 111 22 33" \
        transformation=swiss-phone
```{{execute T1}}

> Because the `allowed_roles` was set to wildcard (`*`), you can use any of the existing role to invoke this transformation. You don't have to add it to the `payments` role; however, being more explicit would be a good practice. 
