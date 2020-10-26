Write policies which fulfill the following policy requirements:

(1) Each _user_ can perform all operations on their allocated key/value secret path (`user-kv/data/<user_name>`)

(2) The education _group_ has a dedicated key/value secret store for each region where all operations can be performed by the group members
 (`group-kv/data/education/<region>`)

(3) The _group_ members can update the group information such as metadata about the group (`identity/group/id/<group_id>`)

> As of Vault 0.11, you can pass in a policy path containing double curly braces as templating delimiters: `{{<parameter>}}`.


## Available Templating Parameters

|                                    Name                                |                                    Description                               |
| :--------------------------------------------------------------------- | :--------------------------------------------------------------------------- |
| `identity.entity.id`                                                   | The entity's ID                                                              |
| `identity.entity.name`                                                 | The entity's name                                                            |
| `identity.entity.metadata.<<metadata key>>`                            | Metadata associated with the entity for the given key                        |
| `identity.entity.aliases.<<mount accessor>>.id`                        | Entity alias ID for the given mount                                          |
| `identity.entity.aliases.<<mount accessor>>.name`                      | Entity alias name for the given mount                                        |
| `identity.entity.aliases.<<mount accessor>>.metadata.<<metadata key>>` | Metadata associated with the alias for the given mount and metadata key      |
| `identity.groups.ids.<<group id>>.name`                                | The group name for the given group ID                                        |
| `identity.groups.names.<<group name>>.id`                              | The group ID for the given group name                                        |
| `identity.groups.names.<<group id>>.metadata.<<metadata key>>`         | Metadata associated with the group for the given key                         |
| `identity.groups.names.<<group name>>.metadata.<<metadata key>>`       | Metadata associated with the group for the given key                         |

<br>


## Author ACL Policies

Open the `user-tmpl.hcl`{{open}} file and enter the following policy rules in the editor (the following snippet can be copied into the editor):

<pre class="file" data-filename="user-tmpl.hcl" data-target="replace">
# Grant permissions on user specific path
path "user-kv/data/{{identity.entity.name}}/*" {
	capabilities = [ "create", "update", "read", "delete", "list" ]
}
</pre>

This policy fulfills the policy requirement 1.

Next, open the `group-tmpl.hcl`{{open}} file and enter the following policy rules in the editor:

<pre class="file" data-filename="group-tmpl.hcl" data-target="replace">
# Grant permissions on the group specific path
# The region is specified in the group metadata
path "group-kv/data/education/{{identity.groups.names.education.metadata.region}}/*" {
	capabilities = [ "create", "update", "read", "delete", "list" ]
}

# Group member can update the group information
path "identity/group/id/{{identity.groups.names.education.id}}" {
  capabilities = [ "update", "read" ]
}
</pre>

This policy fulfills the policy requirement 2 and 3.


## Deploy Policies

Login with root token.

```
vault login root
```{{execute T1}}


Execute the following command to create `user-tmpl` policy:

```
vault policy write user-tmpl user-tmpl.hcl
```{{execute T1}}

Similarly, execute the following command to create `group-tmpl` policy:

```
vault policy write group-tmpl group-tmpl.hcl
```{{execute T1}}

List the available policies to verify:

```
vault policy list
```{{execute T1}}

To clear the screen: `clear`{{execute T1}}
