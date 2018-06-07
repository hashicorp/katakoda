Execute the following command to create a policy:

```
clear
vault policy write base base.hcl
```{{execute}}

Run the following command to list existing policies:

```
vault policy list
```{{execute}}

The list should include the `base` policy you just created.

The following command displays the policy you just created:

```
vault policy read base
```{{execute}}

<br>

***Optional:*** Execute the following command to examine the `default` policy.

```
vault policy read default
```{{execute}}
