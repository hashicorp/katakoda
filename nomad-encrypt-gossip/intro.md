
Nomad server uses a UDP-based gossip protocol to communicate membership and liveness information. Its traffic can be encrypted with symmetric keys. Enabling gossip encryption requires you to set an encryption key when starting the Nomad server. The key can be set via the encrypt parameter or with the `-encrypt` command line option. The key must be a base64-encoded string of sixteen random bytes. The same encryption key should be used on every server in a region.

**Note:** To secure RPC and HTTP communication, you will need to configure TLS. You can learn how in the "Enable TLS Encryption for Nomad" hands-on lab.
