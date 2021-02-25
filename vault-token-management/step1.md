Login with root token.

```
vault login root
```{{execute T1}}


When you create tokens or leases with no specific TTL values, the default value applies to them.

```
vault token create -policy=default
```{{execute T1}}

Notice that the token TTL (`token_duration`) is 768 hours although you did not provide the TTL value.

View the `token` auth method settings.

```
vault auth list -detailed
```{{execute T1}}

```
Path      Plugin    Accessor               Default TTL    Max TTL    Token Type    ...
----      ------    --------               -----------    -------    ----------
token/    token     auth_token_03fa2d1f    system         system     default-service ...
```

The system max TTL is **32 days**, but you can override it to be longer or shorter in Vault's configuration.

The `token` auth method is the core method of authentication with Vault; therefore, Vault enables it by default while other auth methods must be enabled explicitly. Notice that the `token_type` is `default-service`.

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px;">
<p><strong>NOTE: </strong>
The **Default TTL** and **Max TTL** of the `token` auth method is set to `system`.
</p></div>

Read the default TTL settings for **token** auth method.

```
vault read sys/auth/token/tune
```{{execute T1}}

```
Key                  Value
---                  -----
default_lease_ttl    768h
description          token based credentials
force_no_cache       false
max_lease_ttl        768h
token_type           default-service
```

The default token TTL (`default_lease_ttl`) and the max TTL (`max_lease_ttl`) is set to **32 days** (768 hours). This implies that the tokens are valide for 32 days from its creation whether an app is using the token or not.

You can override the default TTL on the `token` auth method itself so that Vault will revoke expired token in a reasonable amount of time.

Sets the default TTL to 8 hours and max TTL to 30 days (720 hours).

```
vault write sys/auth/token/tune default_lease_ttl=8h max_lease_ttl=720h
```{{execute T1}}

Read the configuration to verify.

```
vault read sys/auth/token/tune
```{{execute T1}}

The `default_lease_ttl` value is now 8 hours.


## Verification

Create a new token without specifying its TTL.

```
vault token create -policy=default
```{{execute T1}}

The generated token has its TTL set to 8 hours instead of 32 days (768 hours).
