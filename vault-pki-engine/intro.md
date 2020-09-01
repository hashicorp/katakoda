Vault's PKI secrets engine can dynamically generate X.509 certificates on
demand. This allows services to acquire certificates without the manual process
of generating a private key and Certificate Signing Request (CSR), submitting to
a CA, and then waiting for the verification and signing process to complete.

In this tutorial, you generate a self-signed root certificate. Then you generate
an intermediate certificate which is signed by the root. Finally, you generate a
certificate for the `test.example.com` domain.
