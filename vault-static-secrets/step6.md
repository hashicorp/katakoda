If you wish to permanently delete version(s) of data, run the following command:

```
vault kv destroy -versions=1 secret/company
```{{execute T2}}

Re-run the `get` operation:

```
vault kv get secret/company
```{{execute T2}}

This displays the metadata with `destroyed` parameter value set to **true**.

Furthermore, if you wish to delete all versions and metadata of `secret/company`, run the following command:

```
vault kv metadata delete secret/company
```{{execute T2}}

Now, the `secret/company` no longer exists:

```
vault kv list secret/
```{{execute T2}}
