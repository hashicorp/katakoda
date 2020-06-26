Now, you are going to create an internal group named, engineers.  Its member is `bob-smith` entity that you created.

To clear the screen: `clear`{{execute T1}}

Log back in with the root token:

```
vault login root
```{{execute T1}}


First, create a new policy so that you can test the capability inheritance:

Create a policy named, `team-eng` which grants CRUD operations on the `secret/data/team/eng` path.

```
vault policy write team-eng team-eng.hcl
```{{execute T1}}

To review the policy:  `team-eng.hcl`{{open}}

<br>


## Create Internal Group for Engineers

![Group](./assets/vault-entity-3.png)

Execute the following command to create an internal group named, `engineers` and add `bob-smith` entity as a group member.  Also, assign the newly created `team-eng` policy to the group.

```
vault write -format=json identity/group name="engineers" \
      policies="team-eng" \
      member_entity_ids=$(cat entity_id.txt) \
      metadata=team="Engineering" \
      metadata=region="North America" \
      | jq -r ".data.id" > group_id.txt
```{{execute T1}}

The generated group ID is stored in the `group_id.txt`{{open}} file.

Execute the following command to read the details of the group, `qa-entineers`:

```
vault read identity/group/id/$(cat group_id.txt)
```{{execute T1}}


> By default, Vault creates an internal group. When you create an internal group, you specify the group members, so you don't specify any group alias. Group aliases are mapping between Vault and external identity providers (e.g. LDAP, GitHub, etc.).  Therefore, you define group aliases only when you create external groups.  For internal groups, you have `member_entity_ids` and/or `member_group_ids` instead.
