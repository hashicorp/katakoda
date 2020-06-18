Securing Nomad's cluster communication is not only important for security, but
also eases operations by preventing mistakes and misconfigurations. Nomad
optionally uses mutual TLS (mTLS) for all HTTP and RPC communication. Nomad's
use of mTLS provides the following benefits:

- Prevent unauthorized Nomad access
- Prevent observing or tampering with Nomad communication
- Prevent client/server role or region misconfigurations
- Prevent other services from masquerading as Nomad agents
