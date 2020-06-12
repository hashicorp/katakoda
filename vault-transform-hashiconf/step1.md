First, login with root token.

> Click on the command (`⮐`) will automatically copy it into the terminal and execute it.

```
vault login root
```{{execute T1}}

Execute the following command to install the Vault Enterprise license with Advanced Data Protection (ADP) module.

```
vault write sys/license text="02MV4UU43BK5HGYYTOJZWFQMTMNNEWU33JLJVFSNK2NVCXQTLNLF2E2RDHGFNGSMD2LF5E26KMKRSGWTTNJV2E23KKNBGWUUJUJVCFE222KRATASLJO5UVSM2WPJSEOOLULJMEUZTBK5IWST3JJF4E4VDHGFHEIZDLJZUTC2CZPJCXOTCUKUZVS2TLORHG2RJQJV4TA6SZKRFGST2EKJWU23KJPFHHUZ3JJRBUU4DCNZHDAWKXPBZVSWCSOBRDENLGMFLVC2KPNFEXCSLJO5UWCWCOPJSFOVTGMRDWY5C2KNETMSLKJF3U22SBORGUIWLUJVKEUVKNNJETMTSELE3E4VCVOVHHUWJQJZ5EK6KNIRUGCSLJO5UWGM2SNBRW4UTGMRDWY5C2KNETMSLKJF3U22SBORGUIWLUJVVEUVKNIRATMTKEIE3E2RCCMFEWS53JLJMGQ53BLBFGQZCHNR3GE3BZGBQVOMLMJFVG62KNNJAXSTKDGB3U42JQPFHGYULXJVCG652NIRXXOTKGN5UUYQ2KGBNFQSTUMFLTK2DEI5WHMYTMHEYGCVZRNREWU33JJVVEC6KNIMYHOTTJGB4U6VSRO5GUI33XJVCG652NIZXWSTCDJJ3WG3JZNNSFOTRQJFVG62LENVDDCYSIKFUUYQ2KNVREORTOMN4USNTFPFFHIYRSKIYWER2WPJEWU4DCJFWTCMLCJBJHATCXKJVEYWCONJMVO6DMJFUXO2K2GI4TEWSYJJ2VSVZVNJNFGMLXMIZHQ4CZGNVWSTCDJJUFUSC2NBRG2TTMLJBTC22ZLBJGQTCYIJ4WEM2SNRMTGUTQMIZDI2KYLAYTSLSRMRKDGMCIJNDHGOCPMZFGCNRLIF2GE4TZNRCWW2TENYZWU4KEHBVDKT3MNFLDEVLSPIYXCL22O54G2TCPI5VXI5KBPJIGUY3WFNRFAT2EGJKXIRCQGFBGGSRRFNIVINSVGY2GUQRVGFSEC23DME2GIVRQGMZTQUDXNVLGYYLWJJIDI4CKPBEUSOKEGZKUMTCVMFLFA2TLK5FHIY2EGZYGC3BWN5HWMR3OJMZHUUCLJJJG2R2IKYZWKWTXOFDGKK3PG5VS64ZLIFKE42CQLJTVGL2LKZMWOL2LFNWEOUDXJQ3WUQTYJE3UOT3BNM3FKYLJMFEG6ZLLGBJFI3ZXGJCFCPJ5"
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
