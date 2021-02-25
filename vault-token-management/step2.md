If the token TTL is set reasonably, Vault should not be storing many unused tokens.

Get the service token counts using Vault CLI.

```
vault read sys/internal/counters/tokens
```{{execute T1}}

Get the service token counts using Vault API.

```
curl --header "X-Vault-Token:root" \
       $VAULT_ADDR/v1/sys/internal/counters/tokens | jq .data
```{{execute T1}}

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px;">
<p><strong>NOTE: </strong>
Remember that Vault does not persist batch tokens. Therefore, the `sys/internal/counters/tokens` endpoint returns the number of service tokens in Vault.
</p></div>
