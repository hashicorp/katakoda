Data masking is used to hide sensitive data from those who do not have a clearance to view them. For example, this allows a contractor to test the database environment without having access to the actual sensitive customer information. Data masking has become increasingly important with the enforcement
of [General Data Protection Regulation (GDPR)](https://www.eugdpr.org/) introduced in 2018.

The following steps demonstrate the use of masking to obscure your customer's phone number since it is personally identifiable information (PII).

> **NOTE:** Masking is a unidirectional operation; therefore, `encode` is the only supported operation.

Create a transformation named "phone-number" containing the `phone-number-tmpl` template and allow all roles to use it.

```
vault write transform/transformations/masking/phone-number \
        template=phone-number-tmpl masking_character=# allowed_roles=*
```{{execute T1}}

Notice that the `type` is now set to `masking` and specifies the `masking_character` value instead of `tweak_source`. The default masking character is `*` if you don't specify one.

Create a template named "phone-number-tmpl" with 1~3 digits country code followed by 7~11 digits phone number.

```
vault write transform/template/phone-number-tmpl type=regex \
        pattern="[+]\d{1,3} (\d{7,11})" \
        alphabet=builtin/numeric
```{{execute T1}}

## Test

Test the newly created `phone-number` mask transformation.

First, add the `phone-number` transformation to the `payments` role.

```
vault write transform/role/payments transformations=card-number,uk-passport,phone-number
```{{execute T1}}

Send a test data.

```
vault write transform/encode/payments value="+1 1233455678" \
        transformation=phone-number
```{{execute T1}}
