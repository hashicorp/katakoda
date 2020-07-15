Verify to make sure that Vault has been configured as defined in the `main.tf`.

List the existing namespaces.

```
vault namespace list
```{{execute T1}}

Verify that policies were created.

```
vault policy list
```{{execute T1}}

Check to make sure that `admins` policy was created under the `finance` namespace.

```
vault policy list -ns=finance
```{{execute T1}}

Similarly, check to make sure that `admins` policy was created under the `engineering` namespace.

```
vault policy list -ns=engineering
```{{execute T1}}

Verify that kv-v2 secrets engine is enabled in the `finance` namespace.

```
vault secrets list -ns=finance
```{{execute T1}}

Now, verify that you can log in with `userpass` auth method using the username, "student" and password, "changeme".

```
vault login -method=userpass username="student" password="changeme"
```{{execute T1}}

The generated token has `admins` and `fpe-client` policies attached. Now, take a look at the `fpe-client` policy definition.

```
vault policy read fpe-client
```{{execute T1}}

The `fpe-client` policy permits update operation against the `transform/encode/*` and `transform/decode/*` paths.


Verify the transformation secrets engine configuration for credit card numbers.

List existing transformations.

```
vault list transform/transformation
```{{execute T1}}

Read the `ccn-fpe` transformation details.

```
vault read transform/transformation/ccn-fpe
```{{execute T1}}

List existing transformation templates.

```
vault list transform/template
```{{execute T1}}

Read the `ccn` transformation template definition.

```
vault read transform/template/ccn
```{{execute T1}}

Now, verify that you can log in with `userpass` auth method using the username, "**student**" and password, "**changeme**".

```
vault login -method=userpass username="student" password="changeme"
```{{execute T1}}

The `fpe-client` policy permits update operation against the `transform/encode/*` and `transform/decode/*` paths.

The student user should be able to perform format-preserving encryption (FPE) transformation.

```
vault write transform/encode/payments value=1111-2222-3333-4444
```{{execute T1}}
