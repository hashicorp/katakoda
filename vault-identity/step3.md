To better understand how a token inherits the capabilities from entity's policy, you are going to test it by logging in as bob.

![Entity](./assets/vault-entity-2.png)


Execute the following command to login as `bob`:

```
vault login -method=userpass username=bob password=training
```{{execute T1}}

Upon a successful authentication, a token will be returned. Notice that the output displays **`token_policies`** and **`identity_policies`**. The generated token has both `test` and `base` policies attached.

```
Key                    Value
---                    -----
...
token_policies         ["default" "test"]
identity_policies      ["base"]
policies               ["base" "default" "test"]
token_meta_username    bob
```

Remember that the `test` policy grants CRUD operations on the `secret/test` path.  Check to see if the generated token has capabilities granted:

```
vault kv put secret/test owner="bob"
```{{execute T1}}


> Although the username `bob` does not have `base` policy attached, the token inherits the capabilities granted in the base policy because `bob` is a member of the `bob-smith` entity, and the entity has base policy attached.

Check to see that the bob's token inherited the capabilities:

```
vault token capabilities secret/data/training_test
```{{execute T1}}

Remember that the base policy grants create and read capabilities on path starting with `secret/training`.


## Question

What about the `secret/data/team/qa` path?

Does user `bob` have any permission on that path?

￼<br>

## Answer

The user bob only inherits capability from its associating entity's policy.  The base policy nor test policy grants permissions on the `secret/data/team/qa` path.  Only the `team-qa` policy does.

```
vault token capabilities secret/data/team/qa
```{{execute T1}}

Therefore, the current token has no permission to access the `secret/data/team/qa` path.


> Repeat the steps and login as a user, `bsmith`, and test the token's capabilities.
