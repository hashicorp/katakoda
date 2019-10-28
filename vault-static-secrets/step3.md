View the contents of the file named, `data.json`:   

```
cat data.json
```{{execute T1}}

Now, let's store the data written in `data.json` to Vault at `secret/company` path:

```
vault kv put secret/company @data.json
```{{execute T1}}

> Any value begins with "@" is loaded from a file.

Read the secret in the `secret/company` path:

```
vault kv get secret/company
```{{execute T1}}
