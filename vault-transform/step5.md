Data masking is used to hide sensitive data from those who do not have a clearance to view them. For example, this allows a contractor to test the database environment without having access to the actual sensitive customer information. Data masking has become increasingly important with the enforcement
of [General Data Protection Regulation (GDPR)](https://www.eugdpr.org/) introduced in 2018.

The following steps demonstrate the use of masking to obscure your customer's phone number since it is personally identifiable information (PII).

> **NOTE:** Masking is a unidirectional operation; therefore, `encode` is the only supported operation.

Create a template named "phone-number-tmpl" with country code.

```
vault write transform/template/phone-number-tmpl type=regex \
        pattern="(\+\d{1,2}) (\d{3})-(\d{3})-(\d{4})" \
        alphabet=builtin/numeric
```{{execute T1}}


Create a transformation named "phone-number" containing the `phone-number-tmpl` template and allow all roles to use it.

```
vault write transform/transformation/phone-number type=masking \
        template=phone-number-tmpl masking_character=# allowed_roles=*
```{{execute T1}}

Notice that the `type` is now set to `masking` and specifies the `masking_character` value instead of `tweak_source`. The default masking character is `*` if you don't specify one.

Verify the newly created `phone-number` mask transformation.

First, add the `phone-number` transformation to the `payments` role.

```
vault write transform/role/payments transformations=card-number,uk-passport,phone-number
```{{execute T1}}

Send a test data.

```
vault write transform/encode/payments value="+1 123-345-5678" \
        transformation=phone-number
```{{execute T1}}

<br />

## Use case of the data masking

Think of the US citizen's [Social Security Number (SSN) on a Tax statement](https://www.americanpayroll.org/news-resources/apa-news/news-detail/2019/07/12/irs-finalizes-rules-to-allow-employers-to-mask-ssns-on-employees-w-2s). You don't have to worry about your employees' SSNs securely encrypted and stored in a database. But you still need to worry about the SSN appears on a Tax form, or perhaps online banking statements. This is when you may want to use the data masking to protect the highly sensitive data (SSNs).
