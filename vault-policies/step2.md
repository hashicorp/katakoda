Execute the following command to create a policy:

```
vault policy write base base.hcl
```{{execute T2}}

Run the following command to list existing policies:

```
vault policy list
```{{execute T2}}

The list should include the `base` policy you just created.

The following command displays the policy you just created:

```
vault policy read base
```{{execute T2}}

<br>

***Optional:*** Execute the following command to examine the `default` policy.

```
vault policy read default
```{{execute T2}}
