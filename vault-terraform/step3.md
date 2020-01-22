Terraform makes it easy to update the configuration.

Let's edit the `main.tf` to enable additional Key/Value v2 secrets engine at the `team-edu` path.

Copy the following code.

<pre class="file" data-target="clipboard">
# Enable K/V v2 secrets engine at 'team-edu'
resource "vault_mount" "team-edu" {
  path = "team-edu"
  type = "kv-v2"
  description = "K/V v2 dedicated to the Education Team"
}
</pre>

Paste it into the end of `main.tf`{{open}}.

Now, let's see what happens when you execute the plan command:

```
terraform plan
```{{execute T1}}

```
...
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # vault_mount.team-edu will be created
  + resource "vault_mount" "team-edu" {
      + accessor                  = (known after apply)
      + default_lease_ttl_seconds = (known after apply)
      + id                        = (known after apply)
      + max_lease_ttl_seconds     = (known after apply)
      + path                      = "team-edu"
      + type                      = "kv-v2"
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

The output shows 1 to add and nothing to change or destroy. This is because Terraform has a state file to keep track of current state and identifies that the only change needs to be made is the addition of the `team-edu`.

```
terraform apply -auto-approve
```{{execute T1}}

Now, list the enabled secrets engines to verify:

```
vault secrets list
```{{execute T1}}

```
Path          Type         Accessor              Description
----          ----         --------              -----------
...
team-edu/     kv           kv_9ddb2a46           K/V v2 dedicated to the Education Team
transit/      transit      transit_36211345      n/a
```

The output now includes `team-edu`.

## Question

What happens if you change the `path` from `team-edu` to `team-training` in the `main.tf`{{open}} file and run `terraform plan` and `terraform apply` commands?  Test and see!
