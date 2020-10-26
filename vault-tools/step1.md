First, login with root token.

```
vault login root
```{{execute T1}}


To see the difference between Key/Value secrets engine [version 1](https://www.vaultproject.io/docs/secrets/kv/kv-v1.html) and [version 2](https://www.vaultproject.io/docs/secrets/kv/kv-v1.html), first enable additional KV secrets engines.

```
vault secrets enable -path="kv-v1" -version=1 kv
vault secrets enable -path="kv-v2" -version=2 kv
```{{execute T1}}

Let's list enabled secrets engines to verify:

```
vault secrets list -detailed
```{{execute T1}}

In the output, locate `secret/` and check its version.

```
Path          Type         ...    Options           Description
----          ----         ...    -------           -----------
cubbyhole/    cubbyhole    ...    map[]             per-token private secret storage
identity/     identity     ...    map[]             identity store
kv-v1/        kv           ...    map[version:1]    n/a
kv-v2/        kv           ...    map[version:2]    n/a
secret/       kv           ...    map[version:2]    key/value secret storage
sys/          system       ...    map[]             system endpoints used for control, policy and debugging
```

### Write some secrets

Now, store some secrets at `kv-v1` and `kv-v2` paths. Some test data are provided in the `data.json`{{open}} file.

```
{
  "organization": "ACME Inc.",
  "customer_id": "ABXX2398YZPIE7391",
  "region": "US-West",
  "zip_code": "94105",
  "type": "premium",
  "contact_email": "james@acme.com",
  "status": "active"
}
```

Execute the following commands:

```
vault kv put kv-v1/customers/acme @data.json
vault kv put kv-v2/customers/acme @data.json
```{{execute T1}}

Let's view the secrets written in `kv-v1`:

```
clear
vault kv get kv-v1/customers/acme
```{{execute T1}}

Similarly, view the secrets written in `kv-v2`:

```
vault kv get kv-v2/customers/acme
```{{execute T1}}

Notice that KV v2 keeps track of changes that were made to the secrets; therefore, the data has its _metadata_ associate with it.
