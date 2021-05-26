## Enact the policy

The admin requires the encryption key `transit/encrypt/app-auth` path have the
`update` capability. Key rotation requires the `transit/keys/app-auth/rotate`
path with the `update` capabiltiy. Lastly, configuration requires the
`transit/keys/app-auth/config` with the `update` capability.

```hcl
path "transit/encrypt/app-auth" {
  capabilities = [ "update" ]
}

path "transit/keys/app-auth/rotate" {
  capabilities = [ "update" ]
}

path "transit/keys/app-auth/config" {
  capabilities = [ "update" ]
}
```

Open the `admins-policy.hcl`{{open}} and append the following policies.

<pre class="file" data-filename="admins-policy.hcl" data-target="append">
path "transit/encrypt/app-auth" {
  capabilities = [ "update" ]
}

path "transit/keys/app-auth/rotate" {
  capabilities = [ "update" ]
}

path "transit/keys/app-auth/config" {
  capabilities = [ "update" ]
}
</pre>

Update the policy named `admins-policy`.

```shell
vault policy write admins-policy admins-policy.hcl
```{{execute}}

#### Test the policy

Login with the `admins` user.

```shell
clear
vault login -method=userpass \
  username=admins \
  password=admins-password
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

Wait until the `admins` user is able to perform every operation successfully.
