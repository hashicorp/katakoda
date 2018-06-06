Get help on the delete command:

```
vault kv delete -h
```{{execute}}

This command deletes secrets and configuration from Vault at the given path.

Let's delete `secret/company`:

```
clear
vault kv delete secret/company
```{{execute}}

Try reading the `secret/company` path again.

```
vault kv get secret/company
```{{execute}}

The output displays the metadata with `deletion_time`.

<br>

## Restore the Deleted Secrets

Key/value secret engine v2 allows you to recover from unintentional data loss or overwrite when more than one user is writing at the same path.

Run the following command to recover the deleted data:

```
vault kv undelete -versions=1 secret/company
```{{execute}}

Now, you should be able to read the data again:

```
vault kv get secret/company
```{{execute}}
