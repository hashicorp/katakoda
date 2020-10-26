> Everything in Vault is **path** based, and admins write policies to grant or forbid access to certain paths and operations in Vault. Vault operates on a secure by default standard, and as such, an ***empty policy grants no permissions*** in the system.

First, login with root token.

```
vault login root
```{{execute T1}}


Before begins, let's check which secrets engines have been enabled:  `vault secrets list`{{execute T1}}

The output should look like:

```
Path          Type         Description
----          ----         -----------
cubbyhole/    cubbyhole    per-token private secret storage
identity/     identity     identity store
secret/       kv           key/value secret storage
sys/          system       system endpoints used for control, policy and debugging
```

For each of these path, you must write policies to allow any operation against it.

<br>

## Write a Policy File

You are going to write an ACL policy in [HCL](https://github.com/hashicorp/hcl) format. HCL is JSON compatible; therefore, JSON can be used as completely valid input.

Remember, _an empty policy grants no permission_ in the system. Therefore, ACL policies are defined for each path.

```
path "<PATH>" {
   capabilities = [ "<LIST_OF_CAPABILITIES>" ]
}
```

> The path can have a wildcard ("`*`") at the end to allow for any string in its place. For example, "`secret/training_*`" grants permissions on any path starting with "`secret/training_`" (e.g. `secret/training_vault`). To allow wildcard matching for a single  directory, use "`+`". For example, "`secret/app/+/stage`" would match a path such as "`secret/app/release_1.0/stage`".

<br>


The `base.hcl`{{open}} file should be opened in the editor pane.  Enter the following policy rules in the editor (the following snippet can be copied into the editor):

<pre class="file" data-filename="base.hcl" data-target="replace">
path "secret/data/training_*" {
   capabilities = ["create", "read"]
}

path "secret/data/+/apikey" {
   capabilities = ["create", "read", "update", "delete"]
}
</pre>

Notice that the path has the "splat" operator (`training_*`) as well as single directory wildcard (`+`). This is helpful in working with namespace patterns.  

This policy grants **create** and **read** operations on any path _starting with_ `secret/data/training_`. Also, permits **create**, **read**, **update**, and **delete** operations on any path matching the pattern of `secret/data/<string>/apikey`.

> **NOTE:**  When you are working with [_key/value secrets engine v2_](https://www.vaultproject.io/api/secret/kv/kv-v2.html), the path to write policies would be `secret/data/<path>` even though the K/V command to the path is `secret/<path>`.  When you are working with [v1](https://www.vaultproject.io/api/secret/kv/kv-v1.html), the policies should be written against `secret/<path>`.  This is because the API endpoint to invoke K/V v2 is different from v1.



Get help for the `vault policy` command:

```
vault policy -h
```{{execute T1}}


To view the full list of optional parameters for `vault policy write` operation, run the following command:  `vault policy write -h`{{execute T1}}

To clear the screen: `clear`{{execute T1}}
