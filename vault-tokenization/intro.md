![Vault logo](./assets/Vault_Icon_FullColor.png)


In Vault 1.6, transform secrets engine introduced a new data transformation
method to **tokenize** sensitive data stored outside of Vault. Tokenization
replaces sensitive data with unique values (tokens) that are unrelated to the
original value in any algorithmic sense. Therefore, those tokens cannot risk
exposing the plaintext satisfing the PCI-DSS guidance.

![Tokenization](./assets/vault-tokenization-1.png)


> **Important Note:** Without a valid license, Vault Enterprise server will be sealed after ***30 minutes***. In other words, you have 30 free minutes to explorer the Enterprise features. To explore Vault Enterprise further, you can [sign up for a free 30-day trial](https://www.hashicorp.com/products/vault/trial).
