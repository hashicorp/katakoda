In this tutorial, you learned the basic commands to set resource quotas to protect your Vault environment. To leverage this feature, you need Vault 1.5 or later.

Rate limit quotas allow Vault operators to set inbound request rate limits which can be set on the `root` level or a specific path. This is available in both Vault OSS and Vault Enterprise.

Lease count quotas require Vault Enterprise Platform and allow operators to set the maximum number of tokens and leases to be persisted at any given time. This can prevent Vault from exhausting the resource on the storage backend.

You also learned that audit logging can be enabled to trace the number of requests that were rejected due to the rate limit quota.
