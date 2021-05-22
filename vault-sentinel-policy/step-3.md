```
vault write sys/policies/egp/cidr-check \
        policy=@cidr-check.sentinel \
        paths="secret/data/accounting/*" \
        enforcement_level="soft-mandatory"
```{{execute}}
