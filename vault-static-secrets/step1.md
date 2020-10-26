Login with root token.

```
vault login root
```{{execute T1}}

First, check the current version of the key/value secrets engine that is ready to use.  Run the following command:

```
vault secrets list -detailed
```{{execute T1}}

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

> When you run Vault in development mode, the [key/value version 2](https://www.vaultproject.io/docs/secrets/kv/kv-v2.html) gets enabled by default.  


### Get Help

Run the following command to view the full list of optional parameters `vault kv` operation:

```
vault kv -h
```{{execute T1}}

To clear the screen: `clear`{{execute T1}}
