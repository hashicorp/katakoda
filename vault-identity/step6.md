The most common use case is to create **external groups** where each of the group maps to an external group defined in a third-party identity provider (e.g. Active Directory, OpenLDAP, etc.).  Read [External vs Internal Groups](https://www.vaultproject.io/docs/secrets/identity/index.html#external-vs-internal-groups).

>This challenge section requires a GitHub account with a team membership to perform. Therefore, this step only provides you some hints and tips.

Create an external group which maps to a GitHub team that **your user account** belongs to.  

## Hint:

- [Enable github auth method](https://www.vaultproject.io/intro/getting-started/authentication.html#auth-methods)
- [Configure your GitHub team (`auth/github/map/teams/<team_name>` endpoint)](https://www.vaultproject.io/docs/auth/github.html#configuration)
- [Create a new external group (`identity/group` endpoint)](https://www.vaultproject.io/api/secret/identity/group.html)
- [Create a group alias](https://www.vaultproject.io/api/secret/identity/group-alias.html)

----

## Example Scenario:

Create an external group, `training` which maps to:

- GitHub team: `education`
- GitHub organization: `hashicorp`

**NOTE:** You want to use the _slugfied_ GitHub team name. To find out which GitHub team you belong to:

```bash
$ curl -H "Authorization: token <your_token>" \
      https://api.github.com/user/teams
```

While `<your_token>` is your GitHub API token.  If you do not have one, follow the [GitHub documentation](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/) to create one.

The output should contain the slugfied team namae (`slug`):

```
  {
    "name": "Education",
    "id": 1234567,
    "slug": "education",
    "description": "Education Engineering",
    "privacy": "closed",
    ...
    "organization": {
      "login": "hashicorp",
      ...
  }
]
```

Log back in with the root token:

```
vault login root
```{{execute T1}}

Enable `github` auth method:

```
vault auth enable github
```{{execute T1}}


Configure to point to your GitHub organization (e.g. hashicorp):

```
vault write auth/github/config organization=hashicorp
```

Create a new external group:

```
vault write identity/group name="training" type=external \
       policies="<policy_name>" \
       metadata=organization="<organization>" \
       | jq -r ".data.id" > ext_group_id.txt
```

Notice that the `type` is set to **`external`**.

Retrieve the mount accessor for `github` auth method:

```
vault auth list \
    -format=json | jq -r '.["github/"].accessor' > github_accessor.txt
```{{execute T1}}


Map the `education` team to the `training` group you just created as its group alias:

```
vault write identity/group-alias name="education" \
       mount_accessor=$(cat github_accessor.txt) \
       canonical_id=$(cat ext_group_id.txt)
```{{execute T1}}

> **NOTE:** The `name` is the actual slugfied GitHub team name that you want to map.

To login using your GitHub API token:

```
vault login -method=github token="<your_github_token>"
```

Since your `github` auth method is configured with your organization (e.g. hashicorp), the group membership is managed semi-automatically. If your GitHub username is `sammy22` and belonged to the `education` team, your account inherits the policies attached to the `training` external group.

> **NOTE:** External groups can have **one** (and only one) alias. This alias should map to a notion of group that is outside of the identity store (e.g. groups in LDAP, and teams in GitHub).
