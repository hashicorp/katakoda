First, login with root token.

> Click on the command (`⮐`) will automatically copy it into the terminal and execute it.

```
vault login root
```{{execute T1}}

Execute the following command to install the Vault Enterprise license with Advanced Data Protection (ADP) module.

```
vault write sys/license text="02MV4UU43BK5HGYYTOJZWFQMTMNNEWU33JJ5DVU3KPI5MXOTL2LF2E4V2SNFGVGMBRJ5DUSMCMKRNG2T2XKV2FSMSJO5HFOVJRJVKFSM2ZPJDGSSLJO5UVSM2WPJSEOOLULJMEUZTBK5IWST3JJF4E4VDHGFHEIZDLJZUTC2CZPJCXOTCUKUZVS2TLORHG2RJQJV4TA6SZKRFGST2EKJWU23KJPFHHUZ3JJRBUU4DCNZHDAWKXPBZVSWCSOBRDENLGMFLVC2KPNFEXCSLJO5UWCWCOPJSFOVTGMRDWY5C2KNETMSLKJF3U22SBORGUIWLUJVKGQVKNIRATMTL2JE3E2VCVOVGWUUJRJZCEKNKPIRKTCV3JJFZUS3SOGBMVQSRQLAZVE4DCK5KWST3JJF4U2RCJO5GFIQJSJRKES6CWIRAXOT3KIF3U62SBO5LWSSLTJFWVMNDDI5WHSWKYKJYGEMRVMZSEO3DULJJUSNSJNJEXOTLKIF2E2RCZORGWUWSVJVCECNSNIRATMTKEIJQUS2LXNFSEOVTZMJLWY5KZLBJHAYRSGVTGIR3MORNFGSJWJFVES52NNJAXITKELF2E22TMKVGUIQJWJVCECNSNIRBGCSLJO5UWGSCKOZNEQVTKMRBUSNSJNZNGQZCXPAYES2LXNFNG26DILIZU22KPNZZWSYSXHFVWIV3YNRRXSSJWK54UU5DEK54DAYKTGFVVS6JRPJMTERTTLJJUS42JNVSHMZDNKZ4WE3KGOVMTEVLUMNDTS43BK5HDKSLJO5UVSV2SGJMVONLKLJLVC5C2I5DDAWKTGF3WG3JZGBNFOTRQMFLTS5KJNQYTSZSRHU6S4VZUNJVHOTDLIFHSWUDYOZIHG6DDGI3HO4LFKJTWMOCRKBBESTDTINYTCWDSFNSVQOLMKVTXU2CVMNKG6WKINZWHC2DOINNEC2TTOVCHUZKBJFEEKZC2MRHHGUL2OZSGY33WMZHUEWRRMRAWWY3BGRSFMMBTGM4FA53NKZWGC5SKKA2HASTYJFETSRBWKVDEYVLBKZIGU22XJJ2GGRBWOBQWYNTPJ5TEO3SLGJ5FAS2KKJWUOSCWGNSVU53RIZSSW3ZXNMXXGK2BKRHGQUC2M5JS6S2WLFTS6SZLNRDVA52MG5VEE6CJG5DU6YLLGZKWC2LBJBXWK2ZQKJKG6NZSIRIT2PI"
```{{execute T1}}

Verify that your license allows _Transform Secrets Engine_.

```
vault read sys/license
```{{execute T1}}

The **features** list should contain Transform Secrets Engine. Now, you are ready!


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


To list the existing transformations, execute the following command.

```
vault list transform/transformation
```{{execute T1}}

To view the details of the newly created `card-number` transformation, execute the following command.

```
vault read transform/transformation/card-number
```{{execute T1}}
