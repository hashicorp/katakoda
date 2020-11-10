There is more than one approach to solve the challenge, and this ***sample*** solution.

Step 1: Create a `card-count` transformation

```
vault write transform/transformations/fpe/card-count \
   template=card-count-tmpl \
   tweak_source=internal allowed_roles=payments
```{{execute T1}}

Step 2: Create `card-count-tmpl` transformation template

```
vault write transform/template/card-count-tmpl type=regex \
   pattern="\d{2}(\d{13,15})" \
   alphabet=builtin/numeric
```{{execute T1}}

The regex expression `\d` matches a digit 0 through 9, and `{2}` matches exactly 2 times; therefore, 2 digits numbers. The expression, `{13,15}` matches between 13 and 15 times. Therefore, the `\d{13,15}` matches 13 to 15 digits numbers.
Because `\d{13,15}` is inside the parentheses but `\d{2}` is _NOT_, only the last 13 to 15 digits will be encoded by Vault.

<br />

## Test

Add the transformations to the `payment` role.

```
vault write transform/role/payments transformations=card-number,card-count
```{{execute T1}}

Now, send some data to test your transformation.

Example: American Express card

```
vault write transform/encode/payments value="341111111111111" \
   transformation=card-count
```{{execute T1}}

Example: MasterCard

```
vault write transform/encode/payments value="5111111111111111" \
   transformation=card-count
```{{execute T1}}

Example: Visa card

```
vault write transform/encode/payments value="4222222222222222" \
   transformation=card-count
```{{execute T1}}
