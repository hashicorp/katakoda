Canadian passport numbers have a pattern of two upper-case letters followed by 6
digit numeric.

![](https://education-yh.s3-us-west-2.amazonaws.com/screenshots/vault-transform-1.png)

Use regex to define the matching pattern, `([A-Z]{2}\d{6})`. The matched values should be within a regex grouping (e.g. `(...)`). To create a template for Canadian passports, the commands would look as below.

```
vault write transform/template/ca-passport-tmpl type=regex \
        pattern="([A-Z]{2}\d{6})" \
        alphabet=builtin/alphanumericupper
```{{execute T1}}

> **NOTE:** This example uses the built-in alphabet, `builtin/alphanumericupper`.

## Verification

Create a transformation named "ca-passport" containing the `ca-passport-tmpl` template.

```
vault write transform/transformation/ca-passport type=fpe \
        template=ca-passport-tmpl tweak_source=internal \
        allowed_roles=*
```{{execute T1}}

Update the `payments` role to include the `ca-passport` transformation as well. Alternatively, you can create a new role instead.

```
vault write transform/role/payments transformations=card-number,ca-passport
```{{execute T1}}

In this case, you must specify which `transformation` to use when you send an encode request since the `payments` role has two transformations associate with it.

```
vault write transform/encode/payments value="AB123456" transformation=ca-passport
```{{execute T1}}
