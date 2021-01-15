Enable the azure secrets engine at its default path.

```shell
vault secrets enable azure
```{{execute}}

The secrets engine is enabled at the path `azure/`. To enable the secrets engine
at a different path requires that you use the `-path` parameter and the desired
path.
