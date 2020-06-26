Let's create an entity, **`bob_smith`** with a user **`bob`** as its entity alias. Also, create an internal group, **`education`** and add the **`bob_smith`** entity as its group member.

![Entity](./assets/vault-acl-templating.png)

**NOTE:** For the purpose of this tutorial, you are going to work with the `userpass` auth method to keep this simple.  

## Create an Entity

Execute the following command to enable the userpass auth method:

```
vault auth enable userpass
```{{execute T1}}

First, create a new user, `bob`, in the userpass auth method:

- **username:** bob
- **password:** training

```
vault write auth/userpass/users/bob password="training"
```{{execute T1}}

Execute the following command to discover the mount accessor for the `userpass` auth method since `bob` is defined using the `userpass` auth method:

```
vault auth list \
    -format=json | jq -r '.["userpass/"].accessor' > accessor.txt
```{{execute T1}}

This command parses the output using `jq`, retrieves the mount accessor for `userpass` and save it in the `accessor.txt`{{open}} file.


Execute the following command to create a new entity named, `bob_smith` and save its ID in the `entity_id.txt` file:

```
vault write -format=json identity/entity name="bob_smith" \
     policies="user-tmpl" \
     | jq -r ".data.id" > entity_id.txt
```{{execute T1}}


Now, add user `bob` to the `bob_smith` entity by creating an entity alias:

```
vault write identity/entity-alias name="bob" \
     canonical_id=$(cat entity_id.txt) \
     mount_accessor=$(cat accessor.txt)
```{{execute T1}}

**NOTE:**  If you don't specify the `canonical_id` value, Vault automatically creates a new entity for this alias.  


Execute the following command to read the entity details:

```
vault read -format=json identity/entity/id/$(cat entity_id.txt)
```{{execute T1}}

The user `bob` should be listed as an entity alias under the **`aliases`** block:

```
{
  ...
  "data": {
    "aliases": [
      {
        "canonical_id": "56cba8cd-c1f4-57c3-ca26-10f25bb524e0",
        ...
        "mount_accessor": "auth_userpass_7a1ead56",
        "mount_path": "auth/userpass/",
        "mount_type": "userpass",
        "name": "bob"
      }
    ],
    ...
```

<br>

## Create a Group

Execute the following command to create an internal group named, `education` and add `bob_smith` entity as a group member.  Also, assign the  `group-tmpl` policy to the group, and set some metadata.

```
vault write -format=json identity/group name="education" \
      policies="group-tmpl" \
      member_entity_ids=$(cat entity_id.txt) \
      metadata=region="us-west" \
      | jq -r ".data.id" > group_id.txt
```{{execute T1}}

The generated group ID is stored in the `group_id.txt`{{open}} file.

To clear the screen: `clear`{{execute T1}}
