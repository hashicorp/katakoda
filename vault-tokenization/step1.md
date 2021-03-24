<br />
<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px;">
<p><strong>NOTE: </strong>
**Important Note:** Without a valid license, Vault Enterprise server will be sealed after ***6 hours***. To explore Vault Enterprise further, you can [sign up for a free 30-day trial](https://www.hashicorp.com/products/vault/trial).
</p></div>

<br />

First, login with root token.

```
vault login root
```{{execute T1}}

Create a role named, `mobile-pay` which is attached to `credit-card` transformation. The tokenized value has a fixed maximum time-to-live (TTL) of 24 hours.

![Tokenization](./assets/vault-tokenization-2.png)

Execute the following command to enable the `transform` secrets engine at `transform/`.

```
vault secrets enable transform
```{{execute T1}}

Create a role named `mobile-pay` with a transformation named `credit-card`.

```
vault write transform/role/mobile-pay transformations=credit-card
```{{execute T1}}

The `mobile-pay` role is created.

The role is created but the `credit-card` transformation does not exist, yet. So, let's create a transformation named `credit-card` which sets the generated token's time-to-live (TTL) to 24 hours.

```
vault write transform/transformations/tokenization/credit-card \
    allowed_roles=mobile-pay \
    max_ttl=24h
```{{execute T1}}

The `max_ttl` is an optional parameter which allows you to control how long the token should stay valid.

**NOTE:** Set the `allowed_roles` parameter to a wildcard (`*`) to allow all roles or with globs at the end for pattern matching (e.g. `mobile-*`).

Display details about the `credit-card` transformation.

```
vault read transform/transformations/tokenization/credit-card
```{{execute T1}}

Notice that the `type` is set to `tokenization`.
