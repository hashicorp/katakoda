When you create tokens or leases with no specific TTL values, the default value
applies to them.

```
vault auth list -detailed
```{{execute T1}}

```
Path         Type        Accessor                  Plugin    Default TTL    Max TTL    ...
----         ----        --------                  ------    -----------    -------
approle/     approle     auth_approle_9592c1db     n/a       system         system
token/       token       auth_token_47eac1f8       n/a       system         system
```

The system max TTL is **32 days**, but you can override it to be longer or
shorter in Vault's configuration.

Another option is to tune the mount configuration to override the system
defaults by calling the **`/sys/auth/<METHOD>/tune`** endpoint.

Read the default TTL settings for **token** auth method:

```
vault read sys/auth/token/tune
```{{execute T1}}

```
Key                  Value
---                  -----
default_lease_ttl    768h
force_no_cache       false
max_lease_ttl        768h
token_type           default-service
```

Notice that the `token_type` is `default-service`.
