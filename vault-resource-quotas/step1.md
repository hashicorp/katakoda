**Rate Limit Quotas** is available to all Vault versions, and **Lease Count Quotas** requires Vault Enterprise Platform.

> **Important Note:** Without a valid license, Vault Enterprise server will be sealed after ***6 hours***. To explore Vault Enterprise further, you can [sign up for a free 30-day trial](https://www.hashicorp.com/products/vault/trial).


<br />

Let's begin!  First, login with root token.

```
vault login root
```{{execute T1}}

<br />

## Configure rate limit resource quotas

By default, the requests rejected due to rate limit quota violations are not written to the audit log. Therefore, if you wish to log the rejected requests for traceability, you must set the `enable_rate_limit_audit_logging` to `true`. The requests rejected due to reaching the lease count quotas are always logged that you do not need to set any parameter.

Enable file audit device.

```
vault audit enable file file_path="/var/log/vault-audit.log"
```{{execute T1}}

You can set the target `file_path` to your desired location.

To enable the audit logging for rate limit quotas, execute the following command.

```
vault write sys/quotas/config enable_rate_limit_audit_logging=true
```{{execute T1}}

Read the quota configuration to verify.

```
vault read sys/quotas/config
```{{execute T1}}
