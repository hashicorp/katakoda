![Vault logo](./assets/Vault_Icon_FullColor.png)


**Vault Enterprise 1.4 with Advanced Data Protection module** introduced the **Transform** secrets engine which handles secure data transformation and tokenization against the provided secrets. Transformation methods encompass NIST vetted cryptographic standards such as [format-preserving encryption (FPE)](https://en.wikipedia.org/wiki/Format-preserving_encryption) via [FF3-1](https://csrc.nist.gov/publications/detail/sp/800-38g/rev-1/draft) to encode your secrets while maintaining the data format and length. In addition, it can also be pseudonymous transformations of the data through other means such as masking.

![](./assets/vault-transform.png)

This prevents the need for change in the existing database schema.


> **Important Note:** Without a valid license, Vault Enterprise server will be sealed after ***6 hours***. To explore Vault Enterprise further, you can [sign up for a free 30-day trial](https://www.hashicorp.com/products/vault/trial).
