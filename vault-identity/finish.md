This scenario gave you a quick introduction to using key/value secret engine version 2.

### Resources:

- [Static Secrets - Key/Value Secret Engine guide](https://www.vaultproject.io/guides/secret-mgmt/static-secrets.html)
- [Versioned Key/Value Secret Engine guide](https://www.vaultproject.io/guides/secret-mgmt/versioned-kv.html)
- [Key/Value Secret Engine - Version 2](https://www.vaultproject.io/docs/secrets/kv/kv-v2.html)
- [Key/Value Secret Engine API](https://www.vaultproject.io/api/secret/kv/kv-v2.html)

<br>

## Challenge: Create an External Group and Group Alias

The most common use case is to create external groups each of those groups maps to an external group defined in a third-party identity provider (e.g. Active Directory, OpenLDAP, etc.).

>This challenge section requires a GitHub account with a team membership to perform.

Create an external group which maps to a GitHub team that your user account belongs to.  For example, if your GitHub username, `sammy22` which is a member of the `training` team in hashicorp organization.  Then, create an external group named, `education`, and a group alias named, `training` pointing to the GitHub auth backend (via github auth mount accessor).


To find out which GitHub team you belong to:

```bash
$ curl -H "Authorization: token <your_token>" \
      https://api.github.com/user/teams
```

While `<your_token>` is your GitHub API token.  If you do not have one, follow the [GitHub documentation](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/) to create one.

The output should look like:

    [
      {
        "name": "Training",
        "id": 2074701,
        "slug": "training",
        "description": "Training stuff",
        "privacy": "closed",
        "url": "https://api.github.com/teams/2074701",
        ...
      }
    ]

**NOTE:** You want to use the slugified team name.

#### Hint:

- [Enable github auth method](https://www.vaultproject.io/intro/getting-started/authentication.html#auth-methods)
- Configure your GitHub team (`auth/github/map/teams/<team_name>` endpoint)
- [Create a new external group (`identity/group` endpoint)](https://www.vaultproject.io/api/secret/identity/group.html)
- [Create a group alias](https://www.vaultproject.io/api/secret/identity/group-alias.html) (to get the mount accessor for github, refer to _Step 7.1.8_)
