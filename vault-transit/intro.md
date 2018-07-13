<img src="https://s3-us-west-1.amazonaws.com/education-yh/Vault_Icon_FullColor.png" alt="Logo"/>

[HashiCorp Vault](https://www.vaultproject.io)'s `transit` secrets engine handles cryptographic functions on data in-transit. It can also viewed as _encryption as a service_.  

> **NOTE:** Vault does *not* store the data sent to the secrets engine.  

The primary use case for the `transit` secrets engine is to encrypt data from applications while still storing that encrypted data in some primary data store. This relieves the burden of proper encryption/decryption from application developers and pushes the burden onto the operators of Vault.

![Encryption as a Service](https://s3-us-west-1.amazonaws.com/education-yh/vault-encryption.png)

<br>
This scenario demonstrates the usage of `transit` secrets engine:

- Configure Transit Secret Engine
- Encrypt Secret
- Rotate the Encryption Key
- Rewrap Data
- Update Key Configuration
