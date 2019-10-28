If you wish to permanently delete version(s) of data, run the following command:

```
vault kv destroy -versions=1 secret/company
```{{execute T1}}

Re-run the `get` operation:

```
vault kv get secret/company
```{{execute T1}}

This displays the metadata with `destroyed` parameter value set to **true**.

Furthermore, if you wish to delete all versions and metadata of `secret/company`, run the following command:

```
vault kv metadata delete secret/company
```{{execute T1}}

Now, the `secret/company` no longer exists:

```
vault kv list secret/
```{{execute T1}}

<br>

# Configure Automatic Data Deletion

You can configure the length of time before a version gets deleted. For example, if your organization requires data to be deleted after 10 days from its creation, you can configure the K/V v2 secrets engine to do so by setting the `delete_version_after` parameter.

For demonstration, set the `delete_version_after` to 40 seconds.

```
vault kv metadata put -delete-version-after=40s secret/test
```{{execute T1}}

Write some test data:

```
vault kv put secret/test message="data1"
vault kv put secret/test message="data2"
vault kv put secret/test message="data3"
```{{execute T1}}

Now, check the metadata:

```
vault kv metadata get secret/test
```{{execute T1}}

Notice that the `deletion_time` is set on each version. After 40 seconds, the data gets deleted automatically.

Wait for 40 seconds and try to read **version 1** of the `secret/test` data:

```
vault kv get -version=1 secret/test
```{{execute T1}}

The response only displays the metadata since the data was automatically deleted after 40 seconds of its creation.

```
====== Metadata ======
Key              Value
---              -----
created_time     2019-10-28T20:53:33.984068007Z
deletion_time    2019-10-28T20:54:13.984068007Z
destroyed        false
version          1
```
