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

The administrator requires the ability to maintain Vault's transit encryption
service. This encryption service is maintained in a transit secrets engine
enabled at the path `transit` with a key named `app-auth`.

Login with the `root` user.

```shell
vault login root
```{{execute}}

Encrypt the plaintext with the transit key.

```shell
vault write transit/encrypt/app-auth plaintext=$(base64 <<< "my secret data")
```{{execute}}

Rotate the transit key.

```shell
vault write -f transit/keys/app-auth/rotate
```{{execute}}

Set the minimum decryption version to **2**.

```shell
vault write transit/keys/app-auth/config min_decryption_version=2
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

Select the Transit API tab to read the [Transit API
documentation](https://www.vaultproject.io/api-docs/secret/transit).
