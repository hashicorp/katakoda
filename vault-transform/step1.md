> **Important Note:** Without a valid license, Vault Enterprise server will be sealed after ***6 hours***. To explore Vault Enterprise further, you can [sign up for a free 30-day trial](https://www.hashicorp.com/products/vault/trial).


<br />

First, login with root token.

```
vault login root
```{{execute T1}}

Execute the following command to enable the `transform` secrets engine at `transform/`.

```
vault secrets enable transform
```{{execute T1}}

## Create a role

Create a role named "payments" with "card-number" transformation attached which you will create next.

```
vault write transform/role/payments transformations=card-number
```{{execute T1}}

To list existing roles, execute the following command.

```
vault list transform/role
```{{execute T1}}

## Create a transformation

Create a transformation named "card-number" which will be used to transform credit card numbers. This uses the built-in `builtin/creditcardnumber` template to perform format-preserving encryption (FPE). The allowed role to use this transformation is `payments` you just created.

```
vault write transform/transformations/fpe/card-number \
        template="builtin/creditcardnumber" \
        tweak_source=internal \
        allowed_roles=payments
```{{execute T1}}

**NOTE:** The `allowed_roles` parameter can be set to a wildcard (`*`) instead of listing role names. Also, the role name can be expressed using globs at the end for pattern matching (e.g. `pay*`).

**Tweak source:**

| Source      | Description                                               |
|-------------|-----------------------------------------------------------|
| supplied (default)   | User provide the tweak source which must be a base64-encoded string |
| generated   | Vault generates and returns the tweak source along with the encoded data. The user must securely store the tweak source which will be needed to decrypt the data |
| internal    | Vault generates a tweak source for the transformation and the same tweak source will be used for every request |

> **NOTE:** Tweak source is only applicable to the FPE transformation.


To list the existing transformations, execute the following command.

```
vault list transform/transformation
```{{execute T1}}

To view the details of the newly created `card-number` transformation, execute the following command.

```
vault read transform/transformations/fpe/card-number
```{{execute T1}}
