Now, let's test to make sure that the templated policies work as expected.

First, enable key/value v2 secrets engine at `user-kv` to match the policy:

```
vault secrets enable -path=user-kv kv-v2
```{{execute T1}}

Enable key/value v2 secrets engine at `group-kv`.

```
vault secrets enable -path=group-kv kv-v2
```{{execute T1}}

Now, you are ready to test!  Log in as **`bob`**.

```
vault login -method=userpass username="bob" password="training"
```{{execute T1}}

Notice that the generated token has `default`, `user-tmpl` and `group-tmpl` policies attached where `user-tmpl` policy was inherited from the `bob_smith` entity, and `group-tmpl` from the `education` group.

```
Key                    Value
---                    -----
token                  5f2b2594-f0b4-0a7b-6f51-767345091dcc
token_accessor         78b652dd-4320-f18f-b882-0732b7ae9ac9
token_duration         768h
token_renewable        true
token_policies         ["default"]
identity_policies      ["group-tmpl" "user-tmpl"]
policies               ["default" "group-tmpl" "user-tmpl"]
token_meta_username    bob
```

## Test user-tmpl policy

Remember that `bob` is a member of the `bob_smith` entity; therefore, the `user-kv/data/{{identity.entity.name}}/*` expression in the `user-tmpl.hcl`{{open}} policy translates to **`user-kv/data/bob_smith/*`**.

Let's test!

```
vault kv put user-kv/bob_smith/apikey webapp="12344567890"
```{{execute T1}}

The secret should be created successfully.


## Test group-tmpl policy

The region was set to `us-west` for the `education` group that the `bob_smith` belongs to. Therefore, the `group-kv/data/education/{{identity.groups.names.education.metadata.region}}/*` expression in the `group-tmpl.hcl`{{open}} policy translates to **`group-kv/data/education/us-west/*`**.

Let's verify.

```
vault kv put group-kv/education/us-west/db_cred password="ABCDEFGHIJKLMN"
```{{execute T1}}

The secret should be created successfully.

Now, verify that you can update the group information by adding contact_email metadata. The `group-tmpl` policy permits "update" and "read" on the `identity/group/id/{{identity.groups.names.education.id}}` path. The education group ID is saved in the `group_id.txt` file.

```
vault write identity/group/id/$(cat group_id.txt) \
        policies="group-tmpl" \
        metadata=region="us-west" \
        metadata=contact_email="james@example.com"
```{{execute T1}}

Read the group information to verify that the data has been updated.

```
vault read -format=json identity/group/id/$(cat group_id.txt)
```{{execute T1}}

You should see that `contact_email` metadata has been added.

```
{
  ...
  "data": {
    ...
    "metadata": {
      "contact_email": "james@example.com",
      "region": "us-west"
    },
    ...
}
```
