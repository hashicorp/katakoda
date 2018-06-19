Get help on the delete command:

```
vault kv delete -h
```{{execute T2}}

This command deletes secrets and configuration from Vault at the given path.

To clear the screen: `clear`{{execute T2}}

Let's delete `secret/company`:

```
vault kv delete secret/company
```{{execute T2}}

Try reading the `secret/company` path again.

```
vault kv get secret/company
```{{execute T2}}

The output displays the metadata with `deletion_time`.

<br>

## Restore the Deleted Secrets

Key/value secret engine v2 allows you to recover from unintentional data loss or overwrite when more than one user is writing at the same path.

Run the following command to recover the deleted data:

```
vault kv undelete -versions=1 secret/company
```{{execute T2}}

Now, you should be able to read the data again:

```
vault kv get secret/company
```{{execute T2}}
