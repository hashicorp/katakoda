Verify to make sure that Vault has been configured as defined in the `main.tf`.

List existing policies to make sure that `admins` and `eaas-client` policies were created.

```
vault policy list
```{{execute T1}}

List enabled secrets engines to verify that kv-v2 and transit secrets engines are enabled.

```
vault secrets list
```{{execute T1}}

List to make sure that `payment` key exists.

```
vault list transit/keys
```{{execute T1}}

Now, verify that you can log in with `userpass` auth method using the username, "student" and password, "changeme".

```
vault login -method=userpass username="student" password="changeme"
```{{execute T1}}

The generated token has `eaas-client` policy attached. Review the `eaas-client` policy.


Make sure that student can encrypt and decrypt data using the `payment` key.

```
vault write transit/encrypt/payment plaintext=$(base64 <<< "1111-2222-3333-4444")
```{{execute T1}}


> **NOTE:** The details about how transit secrets engine works are out of scope for this tutorial. If you are not familiar with transit secrets engine, read the [Encryption as a Service: Transit Secrets
Engine](https://www.katacoda.com/hashicorp/scenarios/vault-transit) tutorial.


## Clean up

When you are done exploring, you can undo the configuration made by Terraform.

First log back in with the client token used to run the terraform commnands.

```
vault login root
```{{execute T1}}

Destroy the Vault resources created by Terraform.

```
terraform destroy -auto-approve
```{{execute T1}}

Remove the terraform state files.

```
rm *.tfstate.*
```{{execute T1}}
