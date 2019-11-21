To find out how many service tokens exist on the Vault server or cluster, execute the following command.

```
vault read sys/internal/counters/tokens
```{{execute T1}}

The returned output provides you the token count.

```
Key         Value
---         -----
counters    map[service_tokens:map[total:3]]
```

## Note:

The `sys/internal/counters/tokens` API endpoint is introduced in **Vault 1.3**. To leverage this endpoint, you need Vault 1.3 or later. 
