> **Important Note:** Without a valid license, Vault Enterprise server will be sealed after ***30 minutes***. To explore Vault Enterprise further, you can [sign up for a free 30-day trial](https://www.hashicorp.com/products/vault/trial).


<br />

Let's begin!  First, login with root token.

First, login with root token.

> Click on the command (`⮐`) will automatically copy it into the terminal and execute it.

```
vault login root
```{{execute T1}}

Upload the Vault Enterprise license.

```
vault write sys/license text="02MV4UU43BK5HGYYTOJZWFQMTMNNEWU33JJVWUKNKZNJAXSWTKIF2FS6SNGRMVGMDZJYZFE2CMKRVXUWSEMN2FS3KFGBHGUQJTJZ5GOMK2NJRXSSLJO5UVSM2WPJSEOOLULJMEUZTBK5IWST3JJF4E4VDHGFHEIZDLJZUTC2CZPJCXOTCUKUZVS2TLORHG2RJQJV4TA6SZKRFGST2EKJWU23KJPFHHUZ3JJRBUU4DCNZHDAWKXPBZVSWCSOBRDENLGMFLVC2KPNFEXCSLJO5UWCWCOPJSFOVTGMRDWY5C2KNETMSLKJF3U22SBORGUI23UJVKGQVKNNJETMTLKJE3E2RCZOVHUIUJSJZVGO6CNNJATAV3JJFZUS3SOGBMVQSRQLAZVE4DCK5KWST3JJF4U2RCJO5GFIQJVJRKEKNKWIRAXOT3KIF3U62SBO5LWSSLTJFWVMNDDI5WHSWKYKJYGEMRVMZSEO3DULJJUSNSJNJEXOTLKIF2E2RDLORGWURSVJVCECNSNIRATMTKEIJQUS2LXNFSEOVTZMJLWY5KZLBJHAYRSGVTGIR3MORNFGSJWJFVES52NNJAXITKENN2E22SSKVGUIQJWJVCECNSNIRBGCSLJO5UWGSCKOZNEQVTKMRBUSNSJNZNGQZCXPAYES2LXNFNG26DILIZU22KPNZZWSYSXHFVWIV3YNRRXSSJWK54UU5DEK54DAYKTGFVVS6JRPJMTERTTLJJUS42JNVSHMZDNKZ4WE3KGOVMTEVLUMNDTS43BK5HDKSLJO5UVSV2SGJMVONLKLJLVC5C2I5DDAWKTGF3WG3JZGBNFOTRQMFLTS5KJNQYTSZSRHU6S43SHPBBG6WLVO5ZHOL2JPFDTAVBQIZBTIVCFMZ3DMSJUKZTWYK3UJVSUWOCBMYYVIS3UPJUCWNSVGR2WKMSCPFYFOWDUMRMGY4ZVIJYXIZDNGA4VUWTUJ5WW63DHNNZU23LNMFMEESRRMRAWWY3BGRSFMMBTGM4FA53NKZWGC5SKKA2HASTYJFETSRBWKVDEYVLBKZIGU22XJJ2GGRBWOBQWYNTPJ5TEO3SLGJ5FAS2KKJWUOSCWGNSVU53RIZSSW3ZXNMXXGK2BKRHGQUC2M5JS6S2WLFTS6SZLNRDVA52MG5VEE6CJG5DU6YLLGZKWC2LBJBXWK2ZQKJKG6NZSIRIT2PI"
```{{execute T1}}

Review the license information.

```
vault read sys/license
```{{execute T1}}

This displays the list of features that are available with this license. Also, it displays the license expiration date.

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
vault write transform/transformation/card-number type=fpe \
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
vault read transform/transformation/card-number
```{{execute T1}}
