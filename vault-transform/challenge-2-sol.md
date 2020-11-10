There is more than one approach to solve the challenge, and this ***sample*** solution.

Step 1: Create `swiss-phone` transformation

```
vault write transform/transformations/masking/swiss-phone \
        template=swiss-phone-tmpl allowed_roles=*
```{{execute T1}}


Step 2: Create `swiss-phone-tmpl` template

```
vault write transform/template/swiss-phone-tmpl type=regex \
        pattern="\d{3} (\d{3}) (\d{2}) (\d{2})" \
        alphabet=builtin/numeric
```{{execute T1}}

<br />

## Test

Add the transformations to the `payments` role.

```
vault write transform/role/payments transformations=card-number,card-count,swiss-phone
```{{execute T1}}

Test the transformation with some dummy phone number.

```
vault write transform/encode/payments value="022 111 22 33" \
        transformation=swiss-phone
```{{execute T1}}

> Because the `allowed_roles` was set to wildcard (`*`), you can use any of the existing role to invoke this transformation. You don't have to add it to the `payments` role; however, being more explicit would be a good practice.
