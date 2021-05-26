```
                    ____
                  .'* *.'
               __/_*_*(_
              / _______ \     _______
             _\_)/___\(_/_   < New
            / _((\- -/))_ \      keys. >
            \ \   (-)   / /      ------
             ' \___.___/ '
            / ' \__.__/ ' \
           / _ \ - | - /_  \
          (   ( .;''';. .'  )
          _\"__ /    )\ __"/_
            \/  \   ' /  \/
             .'  '...' ' )
              / /  |  \ \
             / .   .   . \
            /   .     .   \
           /   /   |   \   \
         .'   /    b    '.  '.
     _.-'    /     Bb     '-. '-._
 _.-'       |      BBb       '-.  '-.
(________mrf\____.dBBBb.________)____)
```

The administrator requires the ability to create, update and delete the API keys
stored within Vault. These secrets are maintained in a KV-V2 secrets engine
enabled at the path `external-apis`. The secret path within the engine is
`socials/twitter`.

Login with the `root` user.

```shell
vault login root
```{{execute}}

Create a new secret.

```shell
vault kv put \
    external-apis/socials/instagram \
    api_key=hiKD3vMecH2M6t9TTe9kZW \
    api_secret_key=XEkmqo7pc7BaRkCJZ3kwhLM8VKQBFLW7mG7KUjJTyz
```{{execute}}

Update the secret.

```shell
vault kv put \
    external-apis/socials/twitter \
    api_key=hiKD3vMecH2M6t9TTe9kZW \
    api_secret_key=XEkmqo7pc7BaRkCJZ3kwhLM8VKQBFLW7mG7KUjJTyz
```{{execute}}

Delete a secret.

```shell
vault kv delete external-apis/socials/instagram
```{{execute}}

Undelete a secret.

```shell
vault kv undelete -versions=1 external-apis/socials/instagram
```{{execute}}

## Enact the policy

What policy is required to meet this requirement?

1. Define the policy in the local file.
2. Update the policy named `admins-policy`.
3. Test the policy with the `admins` user.

<br />

#### 1️⃣ with the CLI flags

Run the command with the `-output-curl-string` flag.

#### 2️⃣ with the audit logs

The last command executed is recorded as the last object:

`cat log/vault_audit.log | jq -s ".[-1].request.path,.[-1].request.operation"`.

### 3️⃣ with the API docs

Select the KV-V2 API tab to read the [KV-V2 API
documentation](https://www.vaultproject.io/api-docs/secret/kv/kv-v2).
