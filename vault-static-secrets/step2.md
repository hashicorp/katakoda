Write a secret into `secret/training` path:

```
vault kv put secret/training username="student01" password="pAssw0rd"
```{{execute T1}}

Notice that the output displays the secret's version number.

When running v2 of the key/value backend, a key can retain a configurable number of versions. This defaults to 10 versions. The older versions' metadata and data can be retrieved. Additionally, Check-and-Set operations can be used to avoid overwritting data unintentionally.

## Read the Secrets

To read the secrets in `secret/training` path, run the following command:

```
vault kv get secret/training
```{{execute T1}}

The output displays the metadata of the secret as well as the actual data. The metadata contains the creation time and the version number.


If you want to retrieve only the **username** value from `secret/training`, use the `-field` flag:

```
vault kv get -field=username secret/training
```{{execute T1}}

<br>

### Question

What will happen to the contents of the secret when you execute the following command?

```
vault kv put secret/training password="another-password"
```{{execute T1}}

￼
### Answer

It creates another version of the secret, **version 2**.

```
vault kv get secret/training
```{{execute T1}}

When you read the data at `secret/training`, **username** no longer exists!

> This is very important to understand. The  key/value secrets engine does **NOT** merge or add values. If you want to add/update a key, you must specify all the existing keys as well; otherwise, ***data loss*** can occur!

Execute the following command to rollback the original data (version 1):

```
vault kv rollback -version=1 secret/training
```{{execute T1}}

This creates a new version (**version 3**) of the secret based on version 1.

If you wish to **partially update** the secret value, use `patch`:

```
vault kv patch secret/training course="Vault 101"
```{{execute T1}}

This time, you should see that the `course` value is **added** to the existing key.

```
vault kv get secret/training
```{{execute T1}}



To clear the screen: `clear`{{execute T1}}
