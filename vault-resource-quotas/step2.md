Create a rate limit quota named, "global-rate" which limits inbound workload 30,000 divided by 60 seconds (1 minute) which is 500.

```
vault write sys/quotas/rate-limit/global-rate rate=500
```{{execute T1}}

Read the `global-rate` rule to verify its configuration.

```
vault read sys/quotas/rate-limit/global-rate
```{{execute T1}}

> **NOTE:** In absence of `path`, this quota rule applies to the global level instead of a specific mount or namespace.


## Vault Enterprise Example

Consider that you have K/V v2 secrets engine enabled at `kv-v2` under `us-west` namespace. Create a rate limit quota named, "orders" which limits the incoming requests against `kv-v2` to 1,000 requests per **minute** maximum. In this case, the RPS becomes 16.67 which is 1,000 divided by 60 seconds (1 minute).

Create a namespace, "us-west".

```
vault namespace create us-west
```{{execute T1}}

Enable kv-v2 secrets engine in the `us-west` namespace.

```
vault secrets enable -ns="us-west" kv-v2
```{{execute T1}}

Now, create the `orders` quota rule.

```
vault write sys/quotas/rate-limit/orders \
     path="us-west/kv-v2" \
     rate=16.67
```{{execute T1}}
