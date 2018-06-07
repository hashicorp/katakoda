First, check the current version of the key/value secret engine that is ready to use.  Run the following command:

```
vault secrets list -detailed
```{{execute}}

In the output, locate `secret/` and check its version.

```
Path          Type         ...    Options           Description
----          ----         ...    -------           -----------
cubbyhole/    cubbyhole    ...    map[]             per-token private secret storage
identity/     identity     ...    map[]             identity store
secret/       kv           ...    map[version:2]    key/value secret storage
sys/          system       ...    map[]             system endpoints used for control, policy and debugging
```

Under **Options**, it should display that the kv version is 2.  

> When you run Vault in development mode, the [key/value version 2](https://www.vaultproject.io/docs/secrets/kv/kv-v2.html) gets enabled by default.  If you are running your vault in non-dev mode, [key/value version 1](https://www.vaultproject.io/docs/secrets/kv/kv-v1.html) gets enabled.

Execute the following command to read secrets at `secret/training` path:

```
vault kv get secret/training
```{{execute}}

Expected output: `No value found at secret/training`

<br>

### Get Help

Run the following command to view the full list of optional parameters `vault kv` operation:

```
vault kv -h
```{{execute}}
