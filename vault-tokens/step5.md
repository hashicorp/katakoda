Instead of passing a number of parameters, you can create a role with a set of parameter values set.

Create a token role named `zabbix`.

```
vault write auth/token/roles/zabbix \
    allowed_policies="policy1, policy2, policy3" \
    orphan=true \
    token_ttl=8h
```{{execute T1}}

Create a token for `zabbix` role and save the generated token in a file named, `zabbix-token.txt`.

```
vault token create -role=zabbix -format=json \
   | jq -r ".auth.client_token" > zabbix-token.txt
```{{execute T1}}

Review the token details.

```
vault token lookup $(cat zabbix-token.txt)
```{{execute T1}}

The generated token is valid for 8 hours and it is renewable, and multiple policies are attached.
